import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// The application under test.
import 'package:academic_me/main.dart' as app;

// To run:
// flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Test de integración', () {
    testWidgets('Se añade nota al alumno Juan', (WidgetTester tester) async {
      app.main();

      await tester.pumpAndSettle();

      await addStudentNamedJuan(tester);
      await tester.pumpAndSettle();

      expect(find.textContaining("Juan"), findsWidgets);

      expect(find.text("Asignaturas"), findsOneWidget);
      await tester.tap(find.text("Asignaturas"));
      await tester.pumpAndSettle();
      await addSubjectNamedED(tester);
      await tester.pumpAndSettle();
      expect(find.text("ED"), findsWidgets);

      await tester.tap(find.text("ED"));
      await tester.pumpAndSettle();
      await addExamNamedExamen1(tester);
      await tester.pumpAndSettle();
      expect(find.text("Examen 1"), findsWidgets);

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Estudiantes"));
      await tester.pumpAndSettle();
      await tester.tap(find.textContaining("Juan"));
      await tester.pumpAndSettle();
      await addMarkToStudent(tester);
      await tester.pumpAndSettle();

      expect(find.text("5.5"), findsWidgets);
    });
  });
}

Future addMarkToStudent(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.add));
  await tester.pumpAndSettle();
  await tester.tap(find.text("Nombre"));
  await tester.pumpAndSettle();
  await tester.tap(find.text("Examen 1").first);
  await tester.pumpAndSettle();
  await tester.enterText(find.byType(TextFormField), "5.5");
  await tester.tap(find.byIcon(Icons.save));
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 2), () async {
    await tester.pumpAndSettle();
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
  await Future.delayed(const Duration(seconds: 2), () async {
    await tester.pumpAndSettle();
  });
}

Future addSubjectNamedED(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.add));
  await tester.pumpAndSettle();
  var textFields = find.byType(TextFormField);
  await tester.enterText(textFields.first, "ED");
  await tester.tap(find.byIcon(Icons.save));
  await tester.pumpAndSettle(const Duration(seconds: 2));
  await Future.delayed(const Duration(seconds: 2), () async {
    await tester.pumpAndSettle();
  });
}

Future addExamNamedExamen1(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.add));
  await tester.pumpAndSettle();
  var textFields = find.byType(TextFormField);
  await tester.enterText(textFields.first, "Examen 1");
  await tester.tap(find.byIcon(Icons.save));
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 2), () async {
    await tester.pumpAndSettle();
  });
}
