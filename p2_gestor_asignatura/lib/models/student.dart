import 'dart:math';

import 'mark.dart';

class Student {
  int _id;
  String name;
  final _marks = <Mark>{};

  Student(this._id, this.name);

  int get id => _id;

  Set<Mark> get marks => _marks;

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
