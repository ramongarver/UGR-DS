import 'package:flutter/material.dart';
import 'package:p2_gestor_asignatura/screens/exams_list_view.dart';
import 'package:p2_gestor_asignatura/screens/students_list_view.dart';
import 'package:provider/provider.dart';

import 'models/teaching.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Teaching(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de asignatura',
      theme: ThemeData(
        primaryColor: Colors.orange,
        accentColor: Colors.orangeAccent,
        //platform: TargetPlatform.iOS

      ),
      home: MainPage(),
      locale: Locale('es'),
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
    Consumer<Teaching>(builder: (context, teaching, child) => StudentsListView(teaching),),
    Consumer<Teaching>(builder: (context, teaching, child) => ExamsListView(teaching),),
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
        title: const Text('Gestor de asignatura'),
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
            label: 'Exámenes',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
