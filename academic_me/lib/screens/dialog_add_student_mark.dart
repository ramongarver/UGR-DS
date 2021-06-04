import 'package:academic_me/models/exam.dart';
import 'package:academic_me/models/exams.dart';
import 'package:academic_me/models/mark.dart';
import 'package:academic_me/models/marks.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:academic_me/models/student.dart';

class DialogAddStudentMark extends StatefulWidget {
  final Student _student;

  DialogAddStudentMark(this._student, {Key key}) : super(key: key);

  @override
  _DialogAddStudentMarkState createState() => _DialogAddStudentMarkState();
}

class _DialogAddStudentMarkState extends State<DialogAddStudentMark>
    with AfterLayoutMixin<DialogAddStudentMark> {
  double _grade;
  Exam _exam;
  Future<List<DropdownMenuItem<Exam>>> _examsList;
  final _formKey = GlobalKey<FormState>();

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _examsList = _getExamsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Añadir nota'),
          actions: [
            if (_saving)
              CircularProgressIndicator()
            else
              IconButton(icon: Icon(Icons.save), onPressed: _saveAndExit)
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
                        FutureBuilder<List<DropdownMenuItem<Exam>>>(
                            future: _examsList,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return Text(
                                      "No se ha podido obtener la lista de exámenes");
                                }
                                return DropdownButtonFormField<Exam>(
                                  items: snapshot.data,
                                  decoration: InputDecoration(
                                    filled: true,
                                    prefixIcon: Icon(Icons.school),
                                    hintText: 'Nombre del examen',
                                    labelText: 'Nombre',
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _exam = value;
                                    });
                                  },
                                  validator: (exam) {
                                    if (exam == null) {
                                      return 'No se ha seleccionado examen';
                                    }
                                    return null;
                                  },
                                );
                              } else {
                                return CircularProgressIndicator();
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
                            setState(() {
                              _grade =
                                  double.parse(value.replaceFirst(",", "."));
                            });
                          },
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            // only decimal or natural numbers
                            FilteringTextInputFormatter.allow(
                                RegExp(r"^\d*((\.|,)\d)?$")),
                          ],
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'No se ha indicado la nota';
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
    _examsList.then((list) {
      if (list.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "El estudiante ya ha sido evaluado de todos los exámenes")));
      }
    });
  }

  void _saveAndExit() {
    if (_formKey.currentState.validate()) {
      setState(() => _saving = true);
      Mark.createMark(widget._student.id, _exam.id, _grade, "").then((value) {
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

  Future<List<DropdownMenuItem<Exam>>> _getExamsList() async {
    final allExams = await Exams.getExams();
    final allMarks = await Marks.getMarks();

    final notEvaluatedExams = allExams.exams
        // El examen no tiene nota para este alumno
        .where((exam) => !allMarks.marks.any((mark) =>
            mark.studentId == widget._student.id && mark.examId == exam.id));

    return notEvaluatedExams
        .map((exam) =>
            DropdownMenuItem<Exam>(child: Text(exam.name), value: exam))
        .toList();
  }
}
