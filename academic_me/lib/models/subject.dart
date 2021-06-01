import 'exam.dart';
import 'student.dart';

class Subject {
  int _id;
  String name;
  final _exams = <Exam>[];

  Subject(this._id, this.name);

  int get id => _id;
  List<Exam> get exams => _exams;

  void removeStudent(Student s) {
    _exams.forEach((element) {
      element.marks.removeWhere((element) => element.student == s);
    });
  }

  void addExam(Exam c) {
    _exams.add(c);
    _exams.sort((Exam a, Exam b) => a.date.compareTo(b.date));
  }

  void removeExam(Exam e) {
    _exams.remove(e);
  }
}
