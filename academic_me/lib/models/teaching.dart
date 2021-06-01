import 'package:flutter/material.dart';
import 'subject.dart';

import 'mark.dart';
import 'exam.dart';
import 'student.dart';

class Teaching extends ChangeNotifier {
  final _students = <Student>[];
  final _subjects = <Subject>{};

  List<Student> get students => List.unmodifiable(_students);

  Set<Subject> get subjects => Set.unmodifiable(_subjects);

  List<Exam> get exams {
    List<Exam> res = [];
    _subjects.forEach((subject) {
      res.addAll(subject.exams);
    });

    return res;
  }

  void addStudent(Student s) {
    _students.add(s);
    _students.sort((Student a, Student b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  void removeStudent(Student student) {
    _subjects.forEach((s) => s.removeStudent(student));
    _students.remove(student);
    notifyListeners();
  }

  void addExam(Exam exam, Subject subject) {
    subject.addExam(exam);
    notifyListeners();
  }

  void removeExam(Exam e, Subject subject) {
    subject.removeExam(e);
    notifyListeners();
  }

  Student getStudentById(int id) {
    return _students.singleWhere((student) => student.id == id);
  }

  Subject getSubjectByName(String subjectName) {
    return _subjects.singleWhere((subject) => subject.name == subjectName);
  }

  void addMark(Exam exam, Student student, double mark) {
    final newMark = Mark(exam, student, mark);
    student.marks.add(newMark);
    exam.marks.add(newMark);
  }

  void addSubject(int id, String name) {
    _subjects.add(Subject(id, name));
    notifyListeners();
  }

  void removeSubject(Subject s) {
    _subjects.forEach((subject) {
      subject.exams.forEach((exam) {
        removeExam(exam, subject);
      });
    });
    _subjects.remove(s);
    notifyListeners();
  }
}
