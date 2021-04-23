import 'student.dart';
import 'mark.dart';

class Exam {
  DateTime date;
  String name;
  final _marks = <Mark>{};

  Exam(this.name, this.date);

  Set<Mark> get marks => _marks;

  Mark getMarkByStudent(Student student) {
    return _marks.singleWhere((element) => element.student == student);
  }
}
