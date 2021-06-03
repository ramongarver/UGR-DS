import 'package:academic_me/models/exam.dart';
import 'package:flutter/material.dart';

import 'package:academic_me/models/subject.dart';
import 'package:academic_me/models/subjects.dart';
import 'package:academic_me/screens/exams_list_view.dart';
import 'package:academic_me/screens/dialog_add_subject.dart';

class SubjectsListView extends StatefulWidget {
  SubjectsListView({Key key}) : super(key: key);

  @override
  _SubjectsListViewState createState() => _SubjectsListViewState();
}

class _SubjectsListViewState extends State<SubjectsListView> {
  final _biggerFont = TextStyle(fontSize: 18.0);

  Widget _buildSubjects() {
    return FutureBuilder<Subjects>(
        future: Subjects.getSubjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final tiles = snapshot.data.subjects.map(
                (Subject subject) {
                  return ListTile(
                      title: Text(
                        subject.name,
                        style: _biggerFont,
                      ),
                      onLongPress: () {
                        _showRemoveDialog(subject);
                      },
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute<Future<Exam>>(
                            builder: (BuildContext context) {
                          return ExamsListView(subject);
                        })).then((f) => f.then((exam) => setState(() {})));
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

  Future<void> _showRemoveDialog(Subject subject) async {
    return showDialog<Future<Subject>>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar eliminación'),
          content: Text('¿Quieres eliminar la asignatura ${subject.name}?'),
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
                Future<Subject> future = Subject.deleteSubject(subject.id);
                Navigator.of(context).pop(future);
              },
            ),
          ],
        );
      },
    ).then((f) => f.then((subject) => setState(() {})));
  }

  void _pushAddSubject() {
    Navigator.of(context).push(
        MaterialPageRoute<Future<Subject>>(builder: (BuildContext context) {
      return DialogAddSubject();
    })).then((f) => f.then((subject) => setState(() {})));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSubjects(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _pushAddSubject(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
