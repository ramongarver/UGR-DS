import 'dart:convert';

import 'package:academic_me/models/credentials.dart';
import 'package:academic_me/models/student.dart';
import 'package:http/http.dart' as http;

class Students {
  final List<Student> students;

  Students(this.students);

  Students.fromJson(List<dynamic> json)
      : students = json.map<Student>((e) => Student.fromJson(e)).toList() {
    students.sort((a, b) => a.surname.compareTo(b.surname));
  }

  //////////// get //////////////////
  static Future<Students> getStudents() async {
    final response = await http.get(Uri.https(
        Credentials.baseAddress, Credentials.applicationName + 'students'));

    if (response.statusCode == 200)
      return Students.fromJson(jsonDecode(response.body));
    else
      throw Exception('Failed to get students');
  }
}
