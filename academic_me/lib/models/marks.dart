import 'dart:convert';

import 'package:academic_me/models/credentials.dart';
import 'package:academic_me/models/exams.dart';
import 'package:academic_me/models/mark.dart';
import 'package:academic_me/models/students.dart';
import 'package:http/http.dart' as http;

class Marks {
  final List<Mark> marks;

  Marks(this.marks);

  Marks.fromJson(List<dynamic> json, bool withStudent, bool withExam,
      Exams exams, Students students)
      : marks = json
            .map<Mark>(
                (e) => Mark.fromJson(e, withStudent, withExam, exams, students))
            .toList();

  //////////// get //////////////////
  static Future<Marks> getMarks(
      {bool withStudent = false, bool withExam = false}) async {
    final response = await http.get(Uri.https(
        Credentials.baseAddress, Credentials.applicationName + 'notes'));
    Exams exams;
    Students students;
    if (withExam) {
      exams = await Exams.getExams();
    }
    if (withStudent) {
      students = await Students.getStudents();
    }
    if (response.statusCode == 200)
      return Marks.fromJson(
          jsonDecode(response.body), withStudent, withExam, exams, students);
    else
      throw Exception('Failed to get marks');
  }

  static Future<Iterable<Mark>> getMarksStudent(int studentId) async {
    Marks allMarks = await Marks.getMarks();
    return allMarks.marks.where((mark) => mark.studentId == studentId);
  }

  static Future<Iterable<Mark>> getMarksExam(int examId) async {
    Marks allMarks = await Marks.getMarks();
    return allMarks.marks.where((mark) => mark.examId == examId);
  }
}
