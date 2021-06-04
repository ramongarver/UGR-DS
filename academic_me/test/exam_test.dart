import 'dart:io';

import 'package:academic_me/development/my_http_overrides.dart';
import 'package:academic_me/models/mark.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:academic_me/models/student.dart';
import 'package:academic_me/models/exam.dart';
import 'package:academic_me/models/marks.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  final exam = Exam.createExam(
      'Desarrollo de Software - Tema 1', new DateTime(2021, 05, 23), 1);
  group('Estado inicial:', () {
    test('La fecha del examen debe ser 2021/05/23', () async {
      final e = await exam;
      expect(e.date, new DateTime(2021, 05, 23));
    });
    test('El nombre debe ser Desarrollo de Software - Tema 1', () async {
      final e = await exam;
      expect(e.name, 'Desarrollo de Software - Tema 1');
    });
    test('La lista de notas debe ser vacía', () async {
      final e = await exam;
      final marks = await e.marks;
      expect(marks.isEmpty, true);
    });
  });
  group('Calificaciones:', () {
    final student = Student.createStudent(
        'Jose', 'Sanchez', '666666666', 'jose@gmail.com', 'Calle de José, 23');
    Mark mark;
    Iterable<Mark> marks;

    test(
        'La nota 5.0 debe ser asignada al estudiante "Jose" para el examen "Desarrollo de Software - Tema 1"',
        () async {
      final s = await student;
      final e = await exam;
      mark = await Mark.createMark(s.id, e.id, 5.0, '');
      marks = await Marks.getMarksStudent(s.id);
      expect(marks.first.grade, 5.0);
      Mark.deleteMark(mark.id);
      Student.deleteStudent(s.id);
    });
  });
}
