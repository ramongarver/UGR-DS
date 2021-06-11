import 'dart:convert';

import 'package:academic_me/models/credentials.dart';
import 'package:academic_me/models/subject.dart';
import 'package:http/http.dart' as http;

class Subjects {
  final List<Subject> subjects;

  Subjects(this.subjects);

  Subjects.fromJson(List<dynamic> json)
      : subjects = json.map<Subject>((e) => Subject.fromJson(e)).toList() {
    subjects.sort((a, b) => a.name.compareTo(b.name));
  }

  //////////// get //////////////////
  static Future<Subjects> getSubjects() async {
    final response = await http.get(Uri.https(
        Credentials.baseAddress, Credentials.applicationName + 'subjects'));

    if (response.statusCode == 200)
      return Subjects.fromJson(jsonDecode(response.body));
    else
      throw Exception('Failed to get subjects');
  }
}
