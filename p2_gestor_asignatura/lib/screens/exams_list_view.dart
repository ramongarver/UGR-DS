import 'package:flutter/material.dart';

import 'package:p2_gestor_asignatura/models/teaching.dart';
import 'package:p2_gestor_asignatura/models/exam.dart';
import 'package:p2_gestor_asignatura/screens/dialog_add_exam.dart';


class ExamsListView extends StatefulWidget {
  final Teaching _teaching;

  ExamsListView(this._teaching, {Key key}) : super(key: key);

  @override
  _ExamsListViewState createState() => _ExamsListViewState();
}

class _ExamsListViewState extends State<ExamsListView> {
  final _biggerFont = TextStyle(fontSize: 18.0);

  Widget _buildExams() {
    final tiles = widget._teaching.exams.map(
      (Exam exam) {
        return ListTile(
            title: Text(
              exam.name,
              style: _biggerFont,
            ),
            onLongPress: () {
              _showRemoveDialog(exam);
            },
            onTap: () {
              setState(() {
                Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (BuildContext context) {
                  return Text(exam.name); // TODO Mostrar detalles de examen: ExamDetails(exam, widget._teaching);
                })).then((value) => setState(() {}));
              });
            });
      },
    );

    final divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return ListView(children: divided);
  }

  Future<void> _showRemoveDialog(Exam exam) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar eliminación'),
          content: Text('¿Quieres eliminar el examen ${exam.name}?'),
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
                widget._teaching.removeExam(exam);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _pushAddExam() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return DialogAddExam(widget._teaching);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildExams(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _pushAddExam();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
