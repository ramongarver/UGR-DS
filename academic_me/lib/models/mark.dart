import 'dart:convert';

import 'package:academic_me/models/credentials.dart';
import 'package:academic_me/models/exam.dart';
import 'package:academic_me/models/exams.dart';
import 'package:academic_me/models/student.dart';
import 'package:academic_me/models/students.dart';
import 'package:http/http.dart' as http;

class Mark {
  final int id;
  final int studentId;
  final int examId;
  final double grade;
  final String urlPhoto;
  Exam exam;
  Student student;

  static String _tablePath = "notes/";

  static final idProfesorSiempre = 1;

  Mark(this.id, this.studentId, this.examId, this.grade, this.urlPhoto);

  Mark.fromJson(Map<String, dynamic> json, bool withStudent, bool withExam,
      Exams exams, Students students)
      : id = json['id'],
        studentId = json['student_id'],
        examId = json['exam_id'],
        grade = json['nota'] / 10.0,
        urlPhoto = json['photo'] {
    if (withExam) {
      exam = exams.exams.singleWhere((e) => e.id == examId);
    }
    if (withStudent) {
      student = students.students.singleWhere((s) => s.id == studentId);
    }
  }

  //////////// get //////////////////
  static Future<Mark> getMark(int id) async {
    final response = await http.get(Uri.https(Credentials.baseAddress,
        Credentials.applicationName + _tablePath + id.toString()));

    if (response.statusCode == 200)
      return Mark.fromJson(jsonDecode(response.body), false, false, null, null);
    else
      throw Exception('Failed to get mark');
  }

  ////////////// create ///////////////

  static Future<Mark> createMark(
      int studentId, int examId, double grade, String urlPhoto) async {
    final response = await http.post(
      Uri.https(
          Credentials.baseAddress, Credentials.applicationName + _tablePath),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': Credentials.basicAuth
      },
      body: jsonEncode(<String, dynamic>{
        'student_id': studentId,
        'exam_id': examId,
        'nota': (grade * 10).toInt(),
        'photo': urlPhoto
      }),
    );
    if (response.statusCode == 201)
      return Mark.fromJson(jsonDecode(response.body), false, false, null, null);
    else
      throw Exception('Failed to create mark');
  }

//////////// delete //////////////////

  static Future<void> deleteMark(int id) async {
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
      throw Exception('Failed to delete mark.');
  }

  /////////// update /////////

  static Future<Mark> updateMark(int id, double grade, String urlPhoto) async {
    final http.Response response = await http.put(
      Uri.https(Credentials.baseAddress,
          Credentials.applicationName + _tablePath + id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': Credentials.basicAuth
      },
      body: jsonEncode(
          <String, dynamic>{'nota': (grade * 10).toInt(), 'photo': urlPhoto}),
    );
    if (response.statusCode == 200)
      return Mark.fromJson(jsonDecode(response.body), false, false, null, null);
    else
      throw Exception('Failed to update mark');
  }
}
