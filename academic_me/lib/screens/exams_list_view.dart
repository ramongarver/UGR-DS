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
  String _name;
  final _formKey = GlobalKey<FormState>();

  final _biggerFont = TextStyle(fontSize: 18.0);

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _name = widget._subject.name;
  }

  Widget _buildExams() {
    return Column(
      children: [
        SizedBox(height: 12.0),
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextFormField(
              initialValue: _name,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.school),
                hintText: 'Nombre de la asignatura',
                labelText: 'Nombre',
              ),
              onChanged: (value) {
                _name = value;
              },
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'El nombre está vacío';
                }
                return null;
              },
            ),
          ),
        ),
        SizedBox(height: 30.0),
        Center(
            child: Text(
          'Exámenes de la asignatura'.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )),
        FutureBuilder<Exams>(
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
                              if (changed ?? false) setState(() {});
                            });
                          });
                    },
                  );
                  final divided = ListTile.divideTiles(
                    context: context,
                    tiles: tiles,
                  ).toList();

                  return Expanded(child: ListView(children: divided));
                }
              } else if (snapshot.hasError) return Text('${snapshot.error}');
              return Center(child: CircularProgressIndicator());
            }),
      ],
    );
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
      if (deleted ?? false) setState(() {});
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

  void _saveAndExit() {
    if (_formKey.currentState.validate()) {
      setState(() => _saving = true);
      Subject.updateSubject(widget._subject.id, _name).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Asignatura modificada correctamente")));
        Navigator.of(context).pop(true);
      }).catchError((e) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al intentar modificar asignatura")));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Asignatura: " + widget._subject.name),
        actions: [
          if (_saving)
            Center(child: CircularProgressIndicator())
          else
            IconButton(
                icon: Icon(Icons.save),
                onPressed: _saveAndExit,
                tooltip: "Guardar y salir")
        ],
      ),
      body: _buildExams(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _pushAddExam(),
        child: const Icon(Icons.add),
        tooltip: "Añadir examen",
      ),
    );
  }
}
