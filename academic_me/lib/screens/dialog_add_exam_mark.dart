import 'package:academic_me/models/mark.dart';
import 'package:academic_me/models/marks.dart';
import 'package:academic_me/models/student.dart';
import 'package:academic_me/models/students.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:academic_me/models/exam.dart';

class DialogAddExamMark extends StatefulWidget {
  final Exam _exam;

  DialogAddExamMark(this._exam, {Key key}) : super(key: key);

  @override
  _DialogAddExamMarkState createState() => _DialogAddExamMarkState();
}

class _DialogAddExamMarkState extends State<DialogAddExamMark>
    with AfterLayoutMixin<DialogAddExamMark> {
  String _grade;
  Student _student;
  Future<List<DropdownMenuItem<Student>>> _studentsList;
  final _formKey = GlobalKey<FormState>();

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _studentsList = _getStudentsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Añadir nota'),
          actions: [
            if (_saving)
              Center(child: CircularProgressIndicator())
            else
              IconButton(
                  icon: Icon(Icons.save),
                  onPressed: _saveAndExit,
                  tooltip: "Guardar y salir")
          ],
        ),
        body: Center(
            child: Container(
                padding: EdgeInsets.all(20.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FutureBuilder<List<DropdownMenuItem<Student>>>(
                            future: _studentsList,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return Text(
                                      "No se ha podido obtener la lista de exámenes");
                                }
                                return DropdownButtonFormField<Student>(
                                  items: snapshot.data,
                                  decoration: InputDecoration(
                                    filled: true,
                                    prefixIcon: Icon(Icons.person),
                                    hintText: 'Nombre del estudiante',
                                    labelText: 'Nombre',
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _student = value;
                                    });
                                  },
                                  validator: (student) {
                                    if (student == null) {
                                      return 'No se ha seleccionado estudiante';
                                    }
                                    return null;
                                  },
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                        SizedBox(height: 16.0),
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(Icons.rate_review),
                            hintText: 'Nota del examen',
                            labelText: 'Nota',
                          ),
                          onChanged: (value) {
                            setState(() => _grade = value);
                          },
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            // only decimal or natural numbers
                            FilteringTextInputFormatter.allow(
                                RegExp(r"^((\d((\.|,)\d?)?)|(10(.0?)?))$")),
                          ],
                          validator: (text) {
                            if (text == null || text.isEmpty)
                              return 'No se ha indicado la nota';
                            RegExp regex =
                                new RegExp(r"^((\d((\.|,)\d)?)|(10(.0)?))$");
                            if (!regex.hasMatch(text)) {
                              return 'El formato introducido no es válido';
                            }
                            return null;
                          },
                        ),
                      ],
                    )))));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    showSnackbarIfNothingToAdd();
  }

  void showSnackbarIfNothingToAdd() {
    _studentsList.then((list) {
      if (list.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "Todos los estudiantes ya tienen nota para este examen.")));
      }
    });
  }

  void _saveAndExit() {
    if (_formKey.currentState.validate()) {
      setState(() => _saving = true);
      final grade = double.parse(_grade.replaceFirst(",", "."));
      Mark.createMark(_student.id, widget._exam.id, grade, "").then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Nota añadida correctamente")));
        Navigator.of(context).pop(true);
      }).catchError((e) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al intentar añadir nota")));
      });
    } else
      showSnackbarIfNothingToAdd();
  }

  Future<List<DropdownMenuItem<Student>>> _getStudentsList() async {
    final allStudents = await Students.getStudents();
    final allMarks = await Marks.getMarks();

    final notEvaluatedStudents = allStudents.students
        // El estudiante no tiene nota para este examen
        .where((student) => !(allMarks.marks.any((mark) =>
            mark.examId == widget._exam.id && student.id == mark.studentId)));

    return notEvaluatedStudents
        .map((student) => DropdownMenuItem<Student>(
            child: Text(student.completeName), value: student))
        .toList();
  }
}
