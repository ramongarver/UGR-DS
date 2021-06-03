import 'dart:convert';
import 'dart:math';

import 'package:academic_me/models/credentials.dart';
import 'package:academic_me/models/mark.dart';
import 'package:academic_me/models/marks.dart';
import 'package:academic_me/models/students.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Exam {
  final int id;
  final String name;
  final DateTime date;
  final int subjectId;
  Iterable<Mark> _marks;

  static String _tablePath = "exams/";

  static final idProfesorSiempre = 1;

  Exam(this.id, this.name, this.date, this.subjectId);

  Future<Iterable<Mark>> get marks async {
    if (_marks == null) {
      _marks = await _getMarksFromAPI();
      final students = await Students.getStudents();
      _marks.forEach((m) {
        m.student = students.students.singleWhere((e) => e.id == m.studentId);
      });
    }

    return _marks;
  }

  Future<Iterable<Mark>> _getMarksFromAPI() {
    return Marks.getMarksExam(id);
  }

  void updateMarks() {
    _marks = null;
    _getMarksFromAPI().then((value) async {
      _marks = value;
      final students = await Students.getStudents();
      _marks.forEach((m) {
        m.student = students.students.singleWhere((e) => e.id == m.studentId);
      });
    });
  }

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

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'subject_id': subjectId};

  Exam.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        date = DateTime.parse(json['date']),
        subjectId = json['subject_id'];

  //////////// get //////////////////
  static Future<Exam> getExam(int id) async {
    final response = await http.get(Uri.https(Credentials.baseAddress,
        Credentials.applicationName + _tablePath + id.toString()));

    if (response.statusCode == 200)
      return Exam.fromJson(jsonDecode(response.body));
    else
      throw Exception('Failed to get exam');
  }

  ////////////// create ///////////////

  static Future<Exam> createExam(
      String name, DateTime date, int subjectId) async {
    final response = await http.post(
      Uri.https(
          Credentials.baseAddress, Credentials.applicationName + _tablePath),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': Credentials.basicAuth
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'subject_id': subjectId,
        'date': DateFormat('yyyy-MM-dd').format(date)
      }),
    );
    if (response.statusCode == 201)
      return Exam.fromJson(jsonDecode(response.body));
    else
      throw Exception('Failed to create exam');
  }

//////////// delete //////////////////

  static Future<void> deleteExam(int id) async {
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
      throw Exception('Failed to delete exam.');
  }

  /////////// update /////////

  static Future<Exam> updateExam(int id, String name, DateTime date) async {
    final http.Response response = await http.put(
      Uri.https(Credentials.baseAddress,
          Credentials.applicationName + _tablePath + id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': Credentials.basicAuth
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'date': DateFormat('yyyy-MM-dd').format(date)
      }),
    );
    if (response.statusCode == 200)
      return Exam.fromJson(jsonDecode(response.body));
    else
      throw Exception('Failed to update exam');
  }
}
