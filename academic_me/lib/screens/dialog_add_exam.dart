import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:academic_me/models/exam.dart';
import 'package:academic_me/models/subject.dart';
import 'package:intl/intl.dart';

class DialogAddExam extends StatefulWidget {
  final Subject _subject;

  DialogAddExam(this._subject, {Key key}) : super(key: key);

  @override
  _DialogAddExamState createState() => _DialogAddExamState();
}

class _DialogAddExamState extends State<DialogAddExam> {
  String _name = "";
  DateTime _date = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  bool _saving = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Añadir examen'),
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
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(Icons.school),
                            hintText: 'Nombre del examen',
                            labelText: 'Nombre',
                          ),
                          onChanged: (value) {
                            setState(() {
                              _name = value;
                            });
                          },
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'El nombre está vacío';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            Text(DateFormat('yyyy-MM-dd').format(_date)),
                            IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(2018, 3, 5),
                                    maxTime: DateTime(2022, 6, 7),
                                    onChanged: (date) {
                                  setState(() => _date = date);
                                }, onConfirm: (date) {
                                  setState(() => _date = date);
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.es);
                              },
                            )
                          ],
                        )
                      ],
                    )))));
  }

  void _saveAndExit() {
    if (_formKey.currentState.validate()) {
      setState(() => _saving = true);
      Exam.createExam(_name, _date, widget._subject.id).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Examen añadido correctamente")));
        Navigator.of(context).pop(true);
      }).catchError((e) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al intentar añadir examen")));
      });
    }
  }
}
