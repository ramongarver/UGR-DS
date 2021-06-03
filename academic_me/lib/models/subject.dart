import 'dart:convert';

import 'package:academic_me/models/credentials.dart';
import 'package:http/http.dart' as http;

class Subject {
  final int id;
  final String name;
  final int professorId;

  static String _tablePath = "subjects/";

  static final idProfesorSiempre = 1;

  Subject(this.id, this.name, this.professorId);

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'professor_id': professorId};

  Subject.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        professorId = json['professor_id'];

  //////////// get //////////////////
  static Future<Subject> getSubject(int id) async {
    final response = await http.get(Uri.https(Credentials.baseAddress,
        Credentials.applicationName + _tablePath + id.toString()));

    if (response.statusCode == 200)
      return Subject.fromJson(jsonDecode(response.body));
    else
      throw Exception('Failed to get subject');
  }

  ////////////// create ///////////////

  static Future<Subject> createSubject(String name, int professorId) async {
    final response = await http.post(
      Uri.https(
          Credentials.baseAddress, Credentials.applicationName + _tablePath + 'new'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': Credentials.basicAuth
      },
      body: jsonEncode(
          <String, dynamic>{'name': name, 'professor_id': professorId}),
    );
    if (response.statusCode == 201)
      return Subject.fromJson(jsonDecode(response.body));
    else
      throw Exception('Failed to create subject');
  }

//////////// delete //////////////////

  static Future<Subject> deleteSubject(int id) async {
    final http.Response response = await http.delete(
      Uri.https(Credentials.baseAddress,
        Credentials.applicationName + _tablePath + id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': Credentials.basicAuth
      },
    );
    if (response.statusCode == 200)
      return Subject.fromJson(jsonDecode(response.body));
    else
      throw Exception('Failed to delete subject.');
  }

  /////////// update /////////

  static Future<Subject> updateSubject(
      int id, String name, int professorId) async {
    final http.Response response = await http.put(
      Uri.https(Credentials.baseAddress,
        Credentials.applicationName + _tablePath + id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': Credentials.basicAuth
      },
      body: jsonEncode(
          <String, dynamic>{'name': name, 'professor_id': professorId}),
    );
    if (response.statusCode == 201)
      return Subject.fromJson(jsonDecode(response.body));
    else
      throw Exception('Failed to update subject');
  }
}
