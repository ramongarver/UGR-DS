import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:academic_me/models/exam.dart';
import 'package:academic_me/models/teaching.dart';

class DialogAddExamMark extends StatefulWidget {
  final Exam _exam;
  final Teaching _teaching;

  DialogAddExamMark(this._exam, this._teaching, {Key key})
      : super(key: key);

  @override
  _DialogAddExamMarkState createState() => _DialogAddExamMarkState();
}

class _DialogAddExamMarkState extends State<DialogAddExamMark>
    with AfterLayoutMixin<DialogAddExamMark> {
  double _grade;
  String _student = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Añadir nota'),
          actions: [
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
                        DropdownButtonFormField(
                          items: _getStudentsList(),
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
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'El nombre está vacío';
                            }
                            return null;
                          },
                        ),
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
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            // only decimal or natural numbers
                            FilteringTextInputFormatter.allow(
                                RegExp(r"^\d*((\.|,)\d*)?$")),
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
    if (_getStudentsList().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("Ya se ha evaluado a todos los estudiantes en este examen.")));
    }
  }

  void _saveAndExit() {
    if (_formKey.currentState.validate()) {
      widget._teaching.addMark(
          widget._exam,
          widget._teaching.students.firstWhere((student) => student.name == _student),
          _grade);

      Navigator.of(context).pop();
    } else
      showSnackbarIfNothingToAdd();
  }

  List<DropdownMenuItem<String>> _getStudentsList() {
    final notEvaluatedStudents = widget._teaching.students
        // El estudiante no tiene nota para este examen
        .where((student) =>
            !(student.marks.any((mark) => mark.exam == widget._exam)));

    return notEvaluatedStudents
        .map((student) =>
            DropdownMenuItem<String>(child: Text(student.name), value: student.name))
        .toList();
  }
}
