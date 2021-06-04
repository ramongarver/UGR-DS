import 'dart:io';

import 'package:academic_me/development/my_http_overrides.dart';
import 'package:academic_me/models/mark.dart';
import 'package:academic_me/models/marks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:academic_me/models/student.dart';
import 'package:academic_me/models/exam.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  
  final student = Student.createStudent(
      'Jose', 'Sanchez', '666666666', 'jose@gmail.com', 'Calle de José, 23');
  group('Estado inicial:', () {
    test('El nombre debe ser Jose', () async {
      final s = await student;
      expect(s.name, 'Jose');
    });
    test('La lista de notas debe ser vacía', () async {
      final s = await student;
      final marks = await s.marks;
      expect(marks.isEmpty, true);
    });
    test('La media de las calificaciones debe ser un valor nulo', () async {
      final s = await student;
      final mean = await s.mean;
      expect(mean, null);
    });
    test('El máximo de las calificaciones debe ser un valor nulo', () async {
      final s = await student;
      final maximum = await s.maximum;
      expect(maximum, null);
    });
    test('El mínimo de las calificaciones debe ser un valor nulo', () async {
      final s = await student;
      final minimum = await s.minimum;
      expect(minimum, null);
    });
  });
  /*group('Calificaciones y estadística:', () {
    final exam1 = Exam.createExam(
        'Desarrollo de Software - Tema 1', new DateTime(2021, 05, 23), 1);
    final exam2 = Exam.createExam(
        'Desarrollo de Software - Tema 2', new DateTime(2021, 05, 30), 1);

    test('La nota asignada al estudiante para el primer examen debe ser 5.0',
        () async {
      final e = await exam1;
      final s = await student;
      Mark mark = await Mark.createMark(s.id, e.id, 5.0, '');
      Iterable<Mark> marks = await Marks.getMarksStudent(s.id);
      expect(marks.first.grade, 5.0);
    });
    test('La nota asignada al estudiante para el primer examen debe ser 10.0',
        () async {
      final e = await exam2;
      final s = await student;
      Mark mark = await Mark.createMark(s.id, e.id, 10.0, '');
      Iterable<Mark> marks = await Marks.getMarksStudent(s.id);
      expect(marks.first.grade, 10.0);
    });
    test('La lista de notas del estudiante debe contener dos calificaciones',
        () async {
      final s = await student;
      final marks = await s.marks;
      expect(marks.length, 2);
    });
    test('La media de las calificaciones debe ser un 7.5', () async {
      final s = await student;
      expect(s.mean, 7.5);
    });
    test('El máximo de las calificaciones debe ser un 10.0', () async {
      final s = await student;
      expect(s.maximum, 10.0);
    });
    test('El mínimo de las calificaciones debe ser un 5.0', () async {
      final s = await student;
      expect(s.minimum, 5.0);
    });
    test('', () async {
      final s = await student;
      final e1 = await exam1;
      final e2 = await exam2;

    })
  });*/
}
