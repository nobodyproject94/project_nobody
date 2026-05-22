import 'package:flutter/material.dart';
import 'package:project_nobody/day_1/tugas_7_flutter.dart';

class Tugas8Flutter extends StatefulWidget {
  const Tugas8Flutter({super.key});

  @override
  State<Tugas8Flutter> createState() => _Tugas8FlutterState();
}

/// Flutter code sample for [BottomNavigationBar].

class _Tugas8FlutterState extends State<Tugas8Flutter> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Tugas7Flutter(),
    Text('MaestroNesia'),
    //Text('Index 2: School'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('BottomNavigationBar Sample')),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.business),
          //   label: 'Business',
          // ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
