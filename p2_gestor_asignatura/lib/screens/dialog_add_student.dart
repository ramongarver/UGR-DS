import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p2_gestor_asignatura/models/student.dart';
import 'package:p2_gestor_asignatura/models/teaching.dart';

class DialogAddStudent extends StatefulWidget {
  final Teaching _teaching;

  DialogAddStudent(this._teaching, {Key key}) : super(key: key);

  @override
  _DialogAddStudentState createState() => _DialogAddStudentState();
}

class _DialogAddStudentState extends State<DialogAddStudent> {
  int _id;
  String _name = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Añadir alumno'),
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
                          decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(Icons.tag),
                            hintText: 'ID del alumno',
                            labelText: 'ID',
                          ),
                          onChanged: (value) {
                            setState(() => _id = int.parse(value));
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'El ID está vacío';
                            }
                            if (widget._teaching.students.any(
                                (student) => (student.id.toString() == text))) {
                              return 'El ID ya existe';
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(Icons.person),
                            hintText: 'Nombre del alumno',
                            labelText: 'Nombre',
                          ),
                          onChanged: (value) {
                            setState(() => _name = value);
                          },
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'El nombre está vacío';
                            }
                            return null;
                          },
                        ),
                      ],
                      // TODO: Más atributos para estudiante (?)
                    )))));
  }

  void _saveAndExit() {
    if (_formKey.currentState.validate()) {
      widget._teaching.addStudent(Student(_id, _name));
      Navigator.of(context).pop();
    }
  }
}
