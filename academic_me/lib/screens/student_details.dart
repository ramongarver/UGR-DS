import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:academic_me/models/mark.dart';
import 'package:academic_me/models/student.dart';
import 'package:academic_me/screens/dialog_add_student_mark.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';

class StudentDetails extends StatefulWidget {
  final Student _student;

  StudentDetails(this._student, {Key key}) : super(key: key);

  @override
  _StudentDetailsState createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  String _name;
  String _surname;
  String _phone;
  String _email;
  String _address;
  final _biggerFont = TextStyle(fontSize: 18.0);
  final _formKey = GlobalKey<FormState>();
  final decimalPlaces = 2; // decimal places for displaying marks

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _name = widget._student.name;
    _surname = widget._student.surname;
    _phone = widget._student.phone;
    _email = widget._student.email;
    _address = widget._student.address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget._student.completeName),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _pushAddMark();
          },
          child: const Icon(Icons.add),
          tooltip: "Añadir nota",
        ),
        body: ListView(children: [
          SizedBox(height: 12.0),
          buildStudentForm(),
          SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Statistics(widget._student),
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

  Form buildStudentForm() {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: _name,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Nombre del alumno',
                  labelText: 'Nombre',
                ),
                onChanged: (value) {
                  setState(() => _name = value);
                },
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'El nombre está vacío';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                initialValue: _surname,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Apellido(s)',
                ),
                onChanged: (value) {
                  setState(() => _surname = value);
                },
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'El apellido está vacío';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                initialValue: _phone,
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: Icon(Icons.phone_iphone),
                  hintText: 'Teléfono del alumno',
                  labelText: 'Teléfono',
                ),
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  setState(() => _phone = value);
                },
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'El teléfono está vacío';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                initialValue: _email,
                textCapitalization: TextCapitalization.none,
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email del alumno',
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  setState(() => _email = value);
                },
                validator: (value) =>
                    EmailValidator.validate(value) ? null : "Email no válido",
              ),
              SizedBox(height: 16.0),
              TextFormField(
                initialValue: _address,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: Icon(Icons.home),
                  hintText: 'Dirección del alumno',
                  labelText: 'Dirección',
                ),
                keyboardType: TextInputType.streetAddress,
                onChanged: (value) {
                  setState(() => _address = value);
                },
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'La dirección está vacía';
                  }
                  return null;
                },
              ),
            ],
          ),
        ));
  }

  void _saveAndExit() {
    if (_formKey.currentState.validate()) {
      setState(() => _saving = true);
      Student.updateStudent(
              widget._student.id, _name, _surname, _phone, _email, _address)
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Estudiante modificado correctamente")));
        Navigator.of(context).pop(true);
      }).catchError((e) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al intentar modificar estudiante")));
      });
    }
  }

  Widget _buildMarks() {
    return FutureBuilder(
        future: widget._student.marks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final tiles = snapshot.data.map<Widget>(
                (Mark mark) {
                  return ListTile(
                      title: Text(
                        mark.exam.name,
                        style: _biggerFont,
                      ),
                      trailing: Text(mark.grade.toString()),
                      onLongPress: () {
                        _showRemoveMarkDialog(mark);
                      },
                      onTap: () {
                        // TODO: Mostrar diálogo para modificar nota de examen
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
          return Center(child: CircularProgressIndicator());
        });
  }

  void _pushAddMark() {
    Navigator.of(context)
        .push(MaterialPageRoute<bool>(builder: (BuildContext context) {
      return DialogAddStudentMark(widget._student);
    })).then((added) {
      if (added ?? false)
        setState(() {
          widget._student.updateMarks();
        });
    });
  }

  Future<void> _showRemoveMarkDialog(Mark mark) async {
    return showDialog<bool>(
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
                Mark.deleteMark(mark.id).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Nota eliminada correctamente")));
                  Navigator.of(context).pop(true);
                }).catchError((e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Error al intentar eliminar nota")));
                });
              },
            ),
          ],
        );
      },
    ).then((deleted) {
      if (deleted ?? false)
        setState(() {
          widget._student.updateMarks();
        });
    });
  }
}

class Statistics extends StatelessWidget {
  const Statistics(this._student, {Key key}) : super(key: key);

  final Student _student;
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
                      future: _student.mean,
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
                      future: _student.maximum,
                      builder: (context, snapshot) {
                        if (snapshot.hasData)
                          return Text(
                              snapshot.data.toStringAsFixed(_decimalPlaces));
                        return Text("-");
                      },
                      initialData: null),
                  Text(
                    "MÍNIMO",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  FutureBuilder(
                      future: _student.minimum,
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
