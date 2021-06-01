import 'dart:math';

import 'student.dart';
import 'mark.dart';

class Exam {
  int _id;
  DateTime date;
  String name;
  final _marks = <Mark>{};

  Exam(this.name, this.date);

  int get id => _id;

  Set<Mark> get marks => _marks;

  Mark getMarkByStudent(Student student) {
    try {
      return _marks.singleWhere((element) => element.student == student);
    } catch (e) {
      throw StateError("No hay ninguna nota: $e");
    }
  }

  double get mean {
    if (_marks.isEmpty)
      return null;
    else
      return _marks.map((m) => m.grade).reduce((a, b) => a + b) / _marks.length;
  }

  double get maximum {
    if (_marks.isEmpty)
      return null;
    else
      return _marks.map((m) => m.grade).reduce(max);
  }

  double get minimum {
    if (_marks.isEmpty)
      return null;
    else
      return _marks.map((m) => m.grade).reduce(min);
  }
}
