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
  setUpAll(() {
    HttpOverrides.global = new MyHttpOverrides();
  });

  group("Página de asignaturas 1", () {
    testWidgets('Intentar añadir asignatura: nombre vacío',
        (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.tap(find.text("Asignaturas"));
      await tester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.text("Biologia"), findsOneWidget);
      // Click en botón +
      /*await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await tester.tap(find.byIcon(Icons.save));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.textContaining("nombre está vacío"), findsOneWidget);*/
    });
  });
}
