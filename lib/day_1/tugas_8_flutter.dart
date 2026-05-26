import 'package:flutter/material.dart';
import 'package:project_nobody/day_1/about_app_screen.dart';
import 'package:project_nobody/day_1/tugas_9_flutter.dart';
import 'package:project_nobody/day_1/tugas_8_flutter_2.dart';

class Tugas8Flutter extends StatefulWidget {
  const Tugas8Flutter({super.key});

  @override
  State<Tugas8Flutter> createState() => _Tugas8FlutterState();
}

/// Flutter code sample for [BottomNavigationBar].

class _Tugas8FlutterState extends State<Tugas8Flutter> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    AboutAppScreen(),
    Tugas9Flutter(),
    Tugas8Flutter2(),
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
      // Tambahkan ini di dalam Scaffold
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('Menu Utama')),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                _onItemTapped(0); // Pindah ke index 0
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('List Category'), // <--- INI NO 2
              onTap: () {
                _onItemTapped(1); // <--- Ubah ke index 1
                Navigator.pop(context); // Tutup drawer setelah diklik
              },
            ),
            ListTile(
              title: const Text('Detail App'),
              onTap: () {
                _onItemTapped(2); // Pindah ke index 2
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Menggunakan fungsi yang sama!
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
