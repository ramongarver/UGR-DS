import 'dart:convert';

import 'package:academic_me/models/credentials.dart';
import 'package:academic_me/models/exam.dart';
import 'package:http/http.dart' as http;

class Exams {
  final List<Exam> exams;

  Exams(this.exams);

  Exams.fromJson(List<dynamic> json)
      : exams = json.map<Exam>((e) => Exam.fromJson(e)).toList();

  //////////// get //////////////////
  static Future<Exams> getExams() async {
    final response = await http.get(Uri.https(Credentials.baseAddress,
        Credentials.applicationName + 'exams'));

    if (response.statusCode == 200)
      return Exams.fromJson(jsonDecode(response.body));
    else
      throw Exception('Failed to get exams');
  }
}
