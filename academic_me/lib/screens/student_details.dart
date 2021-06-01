import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:academic_me/models/mark.dart';
import 'package:academic_me/models/student.dart';
import 'package:academic_me/models/teaching.dart';
import 'package:academic_me/screens/dialog_add_student_mark.dart';

class StudentDetails extends StatefulWidget {
  final Student _student;
  final Teaching _teaching;

  StudentDetails(this._student, this._teaching, {Key key}) : super(key: key);

  @override
  _StudentDetailsState createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  String _name;
  String _lastName;
  final _biggerFont = TextStyle(fontSize: 18.0);
  final _formKey = GlobalKey<FormState>();
  final decimalPlaces = 2; // decimal places for displaying marks

  @override
  void initState() {
    super.initState();
    _name = widget._student.name;
    _lastName = widget._student.lastName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget._student.name),
          actions: [
            IconButton(icon: Icon(Icons.save), onPressed: _saveAndExit)
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _pushAddMark();
          },
          child: const Icon(Icons.add),
        ),
        body: ListView(children: [
          SizedBox(height: 10.0),
          Form(
              key: _formKey,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    initialValue: widget._student.id.toString(),
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.tag),
                      hintText: 'ID del alumno:',
                      labelText: 'ID',
                    ),
                    enabled: false,
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    initialValue: widget._student.name,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Nombre del estudiante',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _name = value;
                      }); // todo cambiar nombre
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'El nombre está vacío';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    initialValue: widget._student.lastName,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Apellido(s)',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _lastName = value;
                      }); // todo cambiar nombre
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'El apellido está vacío';
                      }
                      return null;
                    },
                  ),
                ),
                // TODO: Más atributos para estudiante (?)
              ])),
          SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Statistics(widget._student),
          ),
          SizedBox(height: 30.0),
          Center(
              child: Text(
            'Exámenes'.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )),
          SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: _buildExamenes(),
          ),
        ]));
  }

  void _saveAndExit() {
    if (_formKey.currentState.validate()) {
      if (widget._student.name != _name) {
        // If input has changed student's name
        widget._student.name = _name;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Se han guardado los cambios")));
      }

      Navigator.of(context).pop();
    }
  }

  Widget _buildExamenes() {
    final tiles = widget._student.marks.map(
      (Mark mark) {
        return ListTile(
            title: Text(
              mark.exam.name,
              style: _biggerFont,
            ),
            trailing: Text(mark.grade.toString()),
            onLongPress: () {
              _showRemoveMarkDialog(mark);
            },
            onTap: () {
              // TODO: Mostrar diálogo para modificar nota de estudiante
            });
      },
    );

    final divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return Card(child: Column(children: divided));
  }

  void _pushAddMark() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return DialogAddStudentMark(widget._student, widget._teaching);
    })).then((value) => setState(() {}));
  }

  Future<void> _showRemoveMarkDialog(Mark mark) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar eliminación'),
          content:
              Text('¿Quieres eliminar la nota del examen ${mark.exam.name}?'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () {
                setState(() {
                  mark.exam.marks.remove(mark);
                  mark.student.marks.remove(mark);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class Statistics extends StatelessWidget {
  const Statistics(this._student, {Key key}) : super(key: key);

  final Student _student;
  final int _decimalPlaces = 2;

  @override
  Widget build(BuildContext context) {
    return Row(
      // TODO solucionar formato (la tarjeta izquierda se queda pequeña)
      children: [
        Expanded(
          child: Card(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "MEDIA",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(_student.mean?.toStringAsFixed(_decimalPlaces) ?? "-"),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "MÁXIMO",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      _student.maximum?.toStringAsFixed(_decimalPlaces) ?? "-"),
                  SizedBox(height: 5.0),
                  Text(
                    "MÍNIMO",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      _student.minimum?.toStringAsFixed(_decimalPlaces) ?? "-"),
                ],
              ),
            ),
          ),
        )
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }
}
