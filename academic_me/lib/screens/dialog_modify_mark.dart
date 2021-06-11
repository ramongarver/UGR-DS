import 'package:academic_me/models/mark.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Visualizar { estudiante, examen }

class ModifyMarkDialog extends StatefulWidget {
  final Mark _mark;
  final Visualizar _visualizar;
  const ModifyMarkDialog(this._mark, this._visualizar, {Key key})
      : super(key: key);

  @override
  _ModifyMarkDialogState createState() => _ModifyMarkDialogState();
}

class _ModifyMarkDialogState extends State<ModifyMarkDialog> {
  String _grade;
  final _formKey = GlobalKey<FormState>();

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _grade = widget._mark.grade.toString();
  }

  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Modificar nota del examen'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget._visualizar == Visualizar.estudiante)
            Text('Nueva nota para el estudiante ${widget._mark.student.name}:')
          else
            Text('Nueva nota para el examen ${widget._mark.exam.name}:'),
          SizedBox(height: 5.0),
          Form(
            key: _formKey,
            child: TextFormField(
              initialValue: _grade,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.rate_review),
                hintText: 'Nota del examen',
                labelText: 'Nota',
              ),
              onChanged: _saving
                  ? null
                  : (value) {
                      setState(() => _grade = value);
                    },
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                // only decimal or natural numbers
                FilteringTextInputFormatter.allow(
                    RegExp(r"^((\d((\.|,)\d?)?)|(10(.0?)?))$")),
              ],
              validator: (text) {
                if (text == null || text.isEmpty)
                  return 'No se ha indicado la nota';
                RegExp regex = new RegExp(r"^((\d((\.|,)\d)?)|(10(.0)?))$");
                if (!regex.hasMatch(text)) {
                  return 'El formato introducido no es válido';
                }
                return null;
              },
            ),
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancelar'),
          onPressed: _saving
              ? null
              : () {
                  Navigator.of(context).pop();
                },
        ),
        if (_saving)
          Center(child: CircularProgressIndicator())
        else
          ElevatedButton(
            child: Text('Guardar'),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                setState(() => _saving = true);
                final grade = double.parse(_grade.replaceFirst(",", "."));
                Mark.updateMark(widget._mark.id, grade, "").then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Nota modificada correctamente")));
                  Navigator.of(context).pop(true);
                }).catchError((e) {
                  setState(() => _saving = false);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Error al intentar modificar nota")));
                });
              }
            },
          ),
      ],
    );
  }
}
