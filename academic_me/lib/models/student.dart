import 'dart:convert';
import 'dart:math';

import 'package:academic_me/models/credentials.dart';
import 'package:academic_me/models/exams.dart';
import 'package:academic_me/models/marks.dart';
import 'package:academic_me/models/mark.dart';
import 'package:http/http.dart' as http;

class Student {
  final int id;
  final String name;
  final String surname;
  final String phone;
  final String email;
  final String address;
  Iterable<Mark> _marks;

  static String _tablePath = "students/";

  Student(
      this.id, this.name, this.surname, this.phone, this.email, this.address);

  Future<Iterable<Mark>> get marks async {
    if (_marks == null) {
      _marks = await _getMarksFromAPI();
      final exams = await Exams.getExams();
      for(final _mark in _marks) {
        _mark.exam = exams.exams.singleWhere((e) => e.id == _mark.examId);
      }
    }

    return _marks;
  }

  Future<Iterable<Mark>> _getMarksFromAPI() {
    return Marks.getMarksStudent(id);
  }

  void updateMarks() {
    _marks = null;
    _getMarksFromAPI().then((value) async {
      _marks = value;
      final exams = await Exams.getExams();
      _marks.forEach((m) {
        m.exam = exams.exams.singleWhere((e) => e.id == m.examId);
      });
    });
  }

  String get completeName => "$name $surname";

  Future<double> get mean async {
    final waitedMarks = await marks;
    if (waitedMarks.isEmpty)
      return null;
    else
      return waitedMarks.map((m) => m.grade).reduce((a, b) => a + b) /
          waitedMarks.length;
  }

  Future<double> get minimum async {
    final waitedMarks = await marks;
    if (waitedMarks.isEmpty)
      return null;
    else
      return waitedMarks.map((m) => m.grade).reduce(min);
  }

  Future<double> get maximum async {
    final waitedMarks = await marks;
    if (waitedMarks.isEmpty)
      return null;
    else
      return waitedMarks.map((m) => m.grade).reduce(max);
  }

  Student.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        surname = json['surname'],
        phone = json['phone'],
        email = json['email'],
        address = json['address'];

  //////////// get //////////////////
  static Future<Student> getStudent(int id) async {
    final response = await http.get(Uri.https(Credentials.baseAddress,
        Credentials.applicationName + _tablePath + id.toString()));

    if (response.statusCode == 200)
      return Student.fromJson(jsonDecode(response.body));
    else
      throw Exception('Failed to get student');
  }

  ////////////// create ///////////////

  static Future<Student> createStudent(String name, String surname,
      String phone, String email, String address) async {
    final response = await http.post(
      Uri.https(
          Credentials.baseAddress, Credentials.applicationName + _tablePath),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': Credentials.basicAuth
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'surname': surname,
        'phone': phone,
        'email': email,
        'address': address,
        'pass': Credentials.password
      }),
    );
    if (response.statusCode == 201)
      return Student.fromJson(jsonDecode(response.body));
    else
      throw Exception('Failed to create student');
  }

//////////// delete //////////////////

  static Future<void> deleteStudent(int id) async {
    final http.Response response = await http.delete(
      Uri.https(Credentials.baseAddress,
          Credentials.applicationName + _tablePath + id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': Credentials.basicAuth
      },
    );
    if (response.statusCode == 200)
      return;
    else
      throw Exception('Failed to delete student.');
  }

  /////////// update /////////

  static Future<Student> updateStudent(int id, String name, String surname,
      String phone, String email, String address) async {
    final http.Response response = await http.put(
      Uri.https(Credentials.baseAddress,
          Credentials.applicationName + _tablePath + id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': Credentials.basicAuth
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'surname': surname,
        'phone': phone,
        'email': email,
        'address': address,
      }),
    );
    if (response.statusCode == 200)
      return Student.fromJson(jsonDecode(response.body));
    else
      throw Exception('Failed to update student');
  }
}
