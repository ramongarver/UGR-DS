import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:academic_me/models/student.dart';
import 'package:academic_me/models/teaching.dart';

class DialogAddStudentMark extends StatefulWidget {
  final Student _student;
  final Teaching _teaching;

  DialogAddStudentMark(this._student, this._teaching, {Key key})
      : super(key: key);

  @override
  _DialogAddStudentMarkState createState() => _DialogAddStudentMarkState();
}

class _DialogAddStudentMarkState extends State<DialogAddStudentMark>
    with AfterLayoutMixin<DialogAddStudentMark> {
  double _grade;
  String _examen = "";
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
                          items: _getExamsList(),
                          decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(Icons.school),
                            hintText: 'Nombre del examen',
                            labelText: 'Nombre',
                          ),
                          onChanged: (value) {
                            setState(() {
                              _examen = value;
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
    if (_getExamsList().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("El estudiante ya ha sido evaluado de todos los exámenes")));
    }
  }

  void _saveAndExit() {
    if (_formKey.currentState.validate()) {
      widget._teaching.addMark(
          widget._teaching.exams.firstWhere((exam) => exam.name == _examen),
          widget._student,
          _grade);

      Navigator.of(context).pop();
    } else
      showSnackbarIfNothingToAdd();
  }

  List<DropdownMenuItem<String>> _getExamsList() {
    final notEvaluatedExams = widget._teaching.exams
        // El estudiante no tiene nota para este examen
        .where((exam) =>
            !(exam.marks.any((mark) => mark.student == widget._student)));

    return notEvaluatedExams
        .map((exam) =>
            DropdownMenuItem<String>(child: Text(exam.name), value: exam.name))
        .toList();
  }
}
