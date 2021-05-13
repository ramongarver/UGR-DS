import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/teaching.dart';
import 'student_details.dart';

import 'dialog_add_student.dart';

class StudentsListView extends StatefulWidget {
  final Teaching _teaching;

  StudentsListView(this._teaching, {Key key}) : super(key: key);

  @override
  _StudentsListViewState createState() => _StudentsListViewState();
}

class _StudentsListViewState extends State<StudentsListView> {
  final _biggerFont = TextStyle(fontSize: 18.0);

  Widget _buildStudents() {
    final tiles = widget._teaching.students.map(
      (Student student) {
        return ListTile(
            title: Text(
              student.name,
              style: _biggerFont,
            ),
            onLongPress: () {
              _showRemoveDialog(student);
            },
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (BuildContext context) {
                return StudentDetails(student, widget._teaching);
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

  Future<void> _showRemoveDialog(Student student) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar eliminación'),
          content: Text('¿Quieres eliminar el alumno ${student.name}?'),
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
                widget._teaching.removeStudent(student);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _pushAddStudent() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return DialogAddStudent(widget._teaching);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildStudents(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _pushAddStudent(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
