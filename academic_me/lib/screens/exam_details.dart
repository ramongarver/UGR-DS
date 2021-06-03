import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:academic_me/models/exam.dart';
import 'package:academic_me/models/mark.dart';
import 'package:academic_me/screens/dialog_add_exam_mark.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class ExamDetails extends StatefulWidget {
  final Exam _exam;

  ExamDetails(this._exam, {Key key}) : super(key: key);

  @override
  _ExamDetailsState createState() => _ExamDetailsState();
}

class _ExamDetailsState extends State<ExamDetails> {
  String _name;
  DateTime _date;

  final _biggerFont = TextStyle(fontSize: 18.0);
  final _formKey = GlobalKey<FormState>();
  final decimalPlaces = 2; // decimal places for displaying marks

  @override
  void initState() {
    super.initState();
    _name = widget._exam.name;
    _date = widget._exam.date;
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: _name,
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
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text(DateFormat('yyyy-MM-dd').format(_date)),
                      IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2018, 3, 5),
                              maxTime: DateTime(2022, 6, 7), onChanged: (date) {
                            setState(() => _date = date);
                          }, onConfirm: (date) {
                            setState(() => _date = date);
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.es);
                        },
                      )
                    ],
                  )
                ],
              )),
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
            child: _buildMarks(),
          ),
        ]));
  }

  void _saveAndExit() {
    if (_formKey.currentState.validate()) {
      Exam.updateExam(widget._exam.id, _name, _date).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Se han guardado los cambios")));
        Navigator.of(context).pop();
      }).catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al intentar modificar examen")));
      });
    }
  }

  Widget _buildMarks() {
    return FutureBuilder(
        future: widget._exam.marks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final tiles = snapshot.data.map<Widget>(
                (Mark mark) {
                  return ListTile(
                      title: Text(
                        "${mark.student.name} ${mark.student.surname}",
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
              ).toList();

              final divided = ListTile.divideTiles(
                context: context,
                tiles: tiles,
              ).toList();

              return Card(child: Column(children: divided));
            }
          } else if (snapshot.hasError) return Text('${snapshot.error}');
          return CircularProgressIndicator();
        });
  }

  void _pushAddMark() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return DialogAddExamMark(widget._exam);
    })).then((value) => setState(() {}));
  }

  Future<void> _showRemoveMarkDialog(Mark mark) async {
    return showDialog<Future<Mark>>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar eliminación'),
          content: Text(
              '¿Quieres eliminar la nota del estudiante ${mark.student.name + mark.student.surname}?'),
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
                Mark.deleteMark(mark.id)
                    .then((value) => Navigator.of(context).pop())
                    .catchError((e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error al intentar borrar nota")));
                });
              },
            ),
          ],
        );
      },
    ).then((value) => setState(() {}));
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
                  FutureBuilder(
                      future: _exam.mean,
                      builder: (context, snapshot) {
                        if (snapshot.hasData)
                          return Text(
                              snapshot.data.toStringAsFixed(_decimalPlaces));
                        return Text("-");
                      },
                      initialData: null),
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
                  FutureBuilder(
                      future: _exam.maximum,
                      builder: (context, snapshot) {
                        if (snapshot.hasData)
                          return Text(
                              snapshot.data.toStringAsFixed(_decimalPlaces));
                        return Text("-");
                      },
                      initialData: null),
                  SizedBox(height: 5.0),
                  Text(
                    "MÍNIMO",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  FutureBuilder(
                      future: _exam.minimum,
                      builder: (context, snapshot) {
                        if (snapshot.hasData)
                          return Text(
                              snapshot.data.toStringAsFixed(_decimalPlaces));
                        return Text("-");
                      },
                      initialData: null),
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
