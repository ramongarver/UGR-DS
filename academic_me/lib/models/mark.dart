import 'exam.dart';
import 'student.dart';

class Mark {
  Student _student;
  Exam _exam;
  double grade;

  Mark(this._exam, this._student, this.grade);

  Student get student => _student;

  Exam get exam => _exam;
}
