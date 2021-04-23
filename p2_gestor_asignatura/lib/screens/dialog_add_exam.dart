import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p2_gestor_asignatura/models/exam.dart';
import 'package:p2_gestor_asignatura/models/teaching.dart';

class DialogAddExam extends StatefulWidget {
  final Teaching _teaching;

  DialogAddExam(this._teaching, {Key key}) : super(key: key);

  @override
  _DialogAddExamState createState() => _DialogAddExamState();
}

class _DialogAddExamState extends State<DialogAddExam> {
  String _name = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Añadir examen'),
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
                        TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(Icons.school),
                            hintText: 'Nombre del examen',
                            labelText: 'Nombre',
                          ),
                          onChanged: (value) {
                            setState(() {
                              _name = value;
                            });
                          },
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'El nombre está vacío';
                            }
                            if (widget._teaching.exams
                                .any((exam) => exam.name == text)) {
                              return 'El nombre ya existe';
                            }
                            return null;
                          },
                        ),
                        // TODO: Elegir fecha y hora del examen para guardarlos.
                      ],
                    )))));
  }

  void _saveAndExit() {
    if (_formKey.currentState.validate()) {
      widget._teaching.addExam(Exam(_name, DateTime.now())); // TODO: ahora mismo se guarda con fecha actual
      Navigator.of(context).pop();
    }
  }
}
