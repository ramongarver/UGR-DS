import 'package:flutter/material.dart';

import 'mark.dart';
import 'exam.dart';
import 'student.dart';

class Teaching extends ChangeNotifier {
  final _students = <Student>[];
  final _exams = <Exam>[];

  List<Student> get students => List.unmodifiable(_students);

  List<Exam> get exams => List.unmodifiable(_exams);

  void addStudent(Student s) {
    _students.add(s);
    _students.sort((Student a, Student b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  void removeStudent(Student s) {
    _exams
        .forEach((exam) => exam.marks.removeWhere((mark) => mark.student == s));
    _students.remove(s);
    notifyListeners();
  }

  void addExam(Exam c) {
    _exams.add(c);
    _exams.sort((Exam a, Exam b) => a.date.compareTo(b.date));
    notifyListeners();
  }

  void removeExam(Exam e) {
    _students.forEach(
        (student) => student.marks.removeWhere((mark) => mark.exam == e));
    _exams.remove(e);
    notifyListeners();
  }

  Student getStudentById(int id) {
    return _students.singleWhere((student) => student.id == id);
  }

  Exam getExamByName(String examName) {
    return _exams.singleWhere((exam) => exam.name == examName);
  }

  void addMark(Exam exam, Student student, double mark) {
    final newMark = Mark(exam, student, mark);
    student.marks.add(newMark);
    exam.marks.add(newMark);
  }
}
