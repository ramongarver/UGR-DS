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
                  .where((exam) => exam.subjectId == widget._subject.id);
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
                        Navigator.of(context).push(MaterialPageRoute<bool>(
                            builder: (BuildContext context) {
                          return ExamDetails(exam);
                        })).then((changed) {
                          if (changed) setState(() {});
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
          } else if (snapshot.hasError) return Text('${snapshot.error}');
          return CircularProgressIndicator();
        });
  }

  Future<void> _showRemoveDialog(Exam exam) async {
    return showDialog<bool>(
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
                Exam.deleteExam(exam.id).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Examen eliminado correctamente")));
                  Navigator.of(context).pop(true);
                }).catchError((e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Error al intentar eliminar examen")));
                });
              },
            ),
          ],
        );
      },
    ).then((deleted) {
      if (deleted) setState(() {});
    });
  }

  void _pushAddExam() {
    Navigator.of(context)
        .push(MaterialPageRoute<bool>(builder: (BuildContext context) {
      return DialogAddExam(widget._subject);
    })).then((added) {
      if (added) setState(() {});
    });
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
