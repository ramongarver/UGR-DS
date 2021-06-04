// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:academic_me/development/my_http_overrides.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:academic_me/main.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();

  group("Página de estudiantes 1", () {
    testWidgets('Intentar añadir estudiante con nombre vacío',
        (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      // Click en botón +
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.save));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.textContaining("nombre está vacío"), findsOneWidget);
    });
  });
  group("Página de estudiantes 2", () {
    testWidgets('Estudiante queda guardado', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await addStudentNamedJuan(tester);
      await tester.pumpAndSettle();
      expect(find.textContaining("Juan"), findsOneWidget);
    });
  });
}

Future addStudentNamedJuan(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.add));
  await tester.pumpAndSettle();
  var textFields = find.byType(TextFormField);
  await tester.enterText(textFields.first, "Juan");
  await tester.enterText(textFields.at(1), "García");
  await tester.enterText(textFields.at(2), "612345678");
  await tester.enterText(textFields.at(3), "juan@gmail.com");
  await tester.enterText(textFields.at(4), "Calle Real, 1");
  await tester.tap(find.byIcon(Icons.save));
  await tester.pumpAndSettle(const Duration(seconds: 2));
}
