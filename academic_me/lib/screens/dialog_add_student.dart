import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:academic_me/models/student.dart';
import 'package:email_validator/email_validator.dart';

class DialogAddStudent extends StatefulWidget {
  @override
  _DialogAddStudentState createState() => _DialogAddStudentState();
}

class _DialogAddStudentState extends State<DialogAddStudent> {
  String _name = "";
  String _surname = "";
  String _phone = "";
  String _email = "";
  String _address = "";

  final _formKey = GlobalKey<FormState>();

  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Añadir alumno'),
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
        body: ListView(children: [
          SizedBox(height: 12.0),
          buildStudentForm(),
          SizedBox(height: 30.0)
        ]));
  }

  void _saveAndExit() {
    if (_formKey.currentState.validate()) {
      setState(() => _saving = true);
      Student.createStudent(_name, _surname, _phone, _email, _address)
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Estudiante añadido correctamente")));
        Navigator.of(context).pop(true);
      }).catchError((e) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al intentar añadir estudiante")));
      });
    }
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
}
