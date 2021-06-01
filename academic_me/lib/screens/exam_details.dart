import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:academic_me/models/exam.dart';
import 'package:academic_me/models/mark.dart';
import 'package:academic_me/models/teaching.dart';

import 'dialog_add_exam_mark.dart';

class ExamDetails extends StatefulWidget {
  final Exam _exam;
  final Teaching _teaching;

  ExamDetails(this._exam, this._teaching, {Key key}) : super(key: key);

  @override
  _ExamDetailsState createState() => _ExamDetailsState();
}

class _ExamDetailsState extends State<ExamDetails> {
  String _name;
  final _biggerFont = TextStyle(fontSize: 18.0);
  final _formKey = GlobalKey<FormState>();
  final decimalPlaces = 2; // decimal places for displaying marks

  @override
  void initState() {
    super.initState();
    _name = widget._exam.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget._exam.name),
          actions: [
            IconButton(icon: Icon(Icons.save), onPressed: _saveAndExit)
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _pushAddMark,
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
                    initialValue: widget._exam.id.toString(),
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
                    initialValue: widget._exam.name,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Nombre del alumno:',
                      labelText: 'Nombre',
                    ),
                    onChanged: nameChangeHandler,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'El nombre está vacío';
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
            child: Statistics(widget._exam),
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

  void nameChangeHandler(value) {
    setState(() => _name = value); // TODO: cambiar nombre
  }

  void _saveAndExit() {
    if (_formKey.currentState.validate()) {
      if (widget._exam.name != _name) {
        // If input has changed student's name
        widget._exam.name = _name;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Se han guardado los cambios")));
      }

      Navigator.of(context).pop();
    }
  }

  Widget _buildExamenes() {
    final tiles = widget._exam.marks.map(
      (Mark mark) {
        return ListTile(
            title: Text(
              mark.student.name + mark.student.lastName,
              style: _biggerFont,
            ),
            trailing: Text(mark.grade.toString()),
            onLongPress: () {
              _showRemoveMarkDialog(mark);
            },
            onTap: () {
              // TODO: Poder modificar nota de examen
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
      return DialogAddExamMark(widget._exam, widget._teaching);
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
  const Statistics(this._exam, {Key key}) : super(key: key);

  final Exam _exam;
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
                  Text(_exam.mean?.toStringAsFixed(_decimalPlaces) ?? "-"),
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
                  Text(_exam.maximum?.toStringAsFixed(_decimalPlaces) ?? "-"),
                  SizedBox(height: 5.0),
                  Text(
                    "MÍNIMO",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(_exam.minimum?.toStringAsFixed(_decimalPlaces) ?? "-"),
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
