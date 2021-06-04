import 'dart:io';
import 'package:academic_me/development/my_http_overrides.dart';
import 'package:flutter/material.dart';
import 'package:academic_me/screens/students_list_view.dart';
import 'package:academic_me/screens/subjects_list_view.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AcademicMe',
      theme: ThemeData(
        primaryColor: Colors.orange,
        accentColor: Colors.orangeAccent,
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.orangeAccent),
      ),
      darkTheme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.grey[850],
          brightness: Brightness.dark,
        ),
        primaryTextTheme: TextTheme(
          headline6: TextStyle(color: Colors.pink),
        ),
        scaffoldBackgroundColor: Colors.grey[900],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.grey[850],
          shape: RoundedRectangleBorder(),
          textTheme: ButtonTextTheme.primary,
        ),
        colorScheme: ColorScheme.dark().copyWith(
          primary: Color(0xffe84545),
          secondary: Color(0xffe84545),
          secondaryVariant: Color(0xff903749),
        ),
      ),
      home: MainPage(),
      locale: Locale('es', 'ES'),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _children = <Widget>[
    StudentsListView(),
    SubjectsListView()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AcademicMe'),
      ),
      body: Center(
        child: _children.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Estudiantes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Asignaturas',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
