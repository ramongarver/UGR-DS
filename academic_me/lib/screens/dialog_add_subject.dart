import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:academic_me/models/teaching.dart';

class DialogAddSubject extends StatefulWidget {
  final Teaching _teaching;

  DialogAddSubject(this._teaching, {Key key}) : super(key: key);

  @override
  _DialogAddSubjectState createState() => _DialogAddSubjectState();
}

class _DialogAddSubjectState extends State<DialogAddSubject> {
  int _id;
  String _name = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Añadir asignatura'),
          actions: [
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
                          decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(Icons.tag),
                            hintText: 'ID de la asignatura',
                            labelText: 'ID',
                          ),
                          onChanged: (value) {
                            setState(() => _id = int.parse(value));
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'El ID está vacío';
                            }
                            if (widget._teaching.subjects.any(
                                (subject) => (subject.id.toString() == text))) {
                              return 'El ID ya existe';
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
      widget._teaching.addSubject(_id, _name);
      Navigator.of(context).pop();
    }
  }
}
