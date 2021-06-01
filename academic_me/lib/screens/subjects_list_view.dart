import 'package:flutter/material.dart';

import 'package:academic_me/models/teaching.dart';
import 'package:academic_me/models/subject.dart';
import 'package:academic_me/screens/exams_list_view.dart';
import 'package:academic_me/screens/dialog_add_subject.dart';

class SubjectsListView extends StatefulWidget {
  final Teaching _teaching;

  SubjectsListView(this._teaching, {Key key}) : super(key: key);

  @override
  _SubjectsListViewState createState() => _SubjectsListViewState();
}

class _SubjectsListViewState extends State<SubjectsListView> {
  final _biggerFont = TextStyle(fontSize: 18.0);

  Widget _buildSubjects() {
    final tiles = widget._teaching.subjects.map(
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
              setState(() {
                Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (BuildContext context) {
                  return ExamsListView(widget._teaching, subject);
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

  Future<void> _showRemoveDialog(Subject subject) async {
    return showDialog<void>(
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
                widget._teaching.removeSubject(subject);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _pushAddSubject() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return DialogAddSubject(widget._teaching);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSubjects(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _pushAddSubject();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
