import 'package:flutter/material.dart';
import 'package:academic_me/models/students.dart';
import 'package:academic_me/models/student.dart';
import 'package:academic_me/screens/student_details.dart';
import 'package:academic_me/screens/dialog_add_student.dart';

class StudentsListView extends StatefulWidget {
  StudentsListView({Key key}) : super(key: key);

  @override
  _StudentsListViewState createState() => _StudentsListViewState();
}

class _StudentsListViewState extends State<StudentsListView> {
  final _biggerFont = TextStyle(fontSize: 18.0);

  Widget _buildStudents() {
    return FutureBuilder<Students>(
        future: Students.getStudents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final tiles = snapshot.data.students.map(
                (Student student) {
                  return ListTile(
                      title: Text(
                        student.completeName,
                        style: _biggerFont,
                      ),
                      onLongPress: () {
                        _showRemoveDialog(student);
                      },
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute<bool>(
                            builder: (BuildContext context) {
                          return StudentDetails(student);
                        })).then((edited) {
                          if (edited ?? false) setState(() {});
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
          return Center(child: CircularProgressIndicator());
        });
  }

  Future<void> _showRemoveDialog(Student student) async {
    return showDialog<bool>(
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
                Student.deleteStudent(student.id).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Estudiante eliminado correctamente")));
                  Navigator.of(context).pop(true);
                }).catchError((e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Error al intentar eliminar estudiante")));
                });
              },
            ),
          ],
        );
      },
    ).then((deleted) {
      if (deleted ?? false) setState(() {});
    });
  }

  void _pushAddStudent() {
    Navigator.of(context)
        .push(MaterialPageRoute<bool>(builder: (BuildContext context) {
      return DialogAddStudent();
    })).then((added) {
      if (added ?? false) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildStudents(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _pushAddStudent(),
        child: const Icon(Icons.add),
        tooltip: "Añadir estudiante",
      ),
    );
  }
}
