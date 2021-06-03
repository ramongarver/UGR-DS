import 'package:academic_me/models/subject.dart';
import 'package:flutter/material.dart';

import 'package:academic_me/models/exams.dart';
import 'package:academic_me/models/exam.dart';
import 'package:academic_me/screens/dialog_add_exam.dart';
import 'package:academic_me/screens/exam_details.dart';

class ExamsListView extends StatefulWidget {
  final Subject _subject;

  ExamsListView(this._subject, {Key key}) : super(key: key);

  @override
  _ExamsListViewState createState() => _ExamsListViewState();
}

class _ExamsListViewState extends State<ExamsListView> {
  final _biggerFont = TextStyle(fontSize: 18.0);

  Widget _buildExams() {
    return FutureBuilder<Exams>(
        future: Exams.getExams(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final filtered = snapshot.data.exams
                  .where((exam) => exam.id == widget._subject.id);
              final tiles = filtered.map(
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
                        Navigator.of(context).push(MaterialPageRoute<void>(
                            builder: (BuildContext context) {
                          return ExamDetails(exam);
                        })).then((value) => setState(() {}));
                      });
                },
              );
              final divided = ListTile.divideTiles(
                context: context,
                tiles: tiles,
              ).toList();

              return ListView(children: divided);
            }
          } else if (snapshot.hasError) return Text('${snapshot.error}');
          return CircularProgressIndicator();
        });
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
                Exam.deleteExam(exam.id)
                    .then((value) => Navigator.of(context).pop())
                    .catchError((e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Error al intentar borrar examen")));
                });
              },
            ),
          ],
        );
      },
    ).then((value) => setState(() {}));
    // TODO: Comprobar si recarga la página si se cancela
  }

  void _pushAddExam() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return DialogAddExam(widget._subject);
    })).then((val) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exámenes de " + widget._subject.name),
        actions: [
          //IconButton(icon: Icon(Icons.save), onPressed: _saveAndExit)
        ],
      ),
      body: _buildExams(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _pushAddExam(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
