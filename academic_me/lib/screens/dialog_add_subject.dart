import 'package:academic_me/models/subject.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DialogAddSubject extends StatefulWidget {
  DialogAddSubject({Key key}) : super(key: key);

  @override
  _DialogAddSubjectState createState() => _DialogAddSubjectState();
}

class _DialogAddSubjectState extends State<DialogAddSubject> {
  String _name = "";
  final _formKey = GlobalKey<FormState>();

  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Añadir asignatura'),
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
                            hintText: 'Nombre de la asignatura',
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
                      ],
                    )))));
  }

  void _saveAndExit() {
    if (_formKey.currentState.validate()) {
      setState(() => _saving = true);
      Subject.createSubject(_name, Subject.idProfesorSiempre).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Asignatura añadida correctamente")));
        Navigator.of(context).pop(true);
      }).catchError((e) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al intentar añadir asignatura")));
      });
    }
  }
}
