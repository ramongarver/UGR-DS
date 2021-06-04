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
              CircularProgressIndicator()
            else
              IconButton(icon: Icon(Icons.save), onPressed: _saveAndExit)
          ],
        ),
        body: Center(
            child: Container(
                padding: EdgeInsets.all(20.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFormField(
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
                          decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(Icons.phone_iphone),
                            hintText: 'Teléfono del alumno',
                            labelText: 'Teléfono',
                          ),
                          keyboardType: TextInputType.phone,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
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
                          textCapitalization: TextCapitalization.none,
                          decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(Icons.email),
                            hintText: 'Email del alumno',
                            labelText: 'Email',
                          ),
                          onChanged: (value) {
                            setState(() => _email = value);
                          },
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => EmailValidator.validate(value)
                              ? null
                              : "Email no válido",
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
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
                    )))));
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
}
