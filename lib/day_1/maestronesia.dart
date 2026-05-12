import 'package:flutter/material.dart';

class Maestronesia extends StatelessWidget {
  const Maestronesia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 9, 49),
      appBar: AppBar(
        title: Text('MaestroNesia'),
        elevation: 4,
        titleTextStyle: TextStyle(color: Colors.lightGreenAccent, fontSize: 25),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 2, 9, 49),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(radius: 29),
          Icon(Icons.store, size: 30, color: Colors.white),
        ],
      ),
    );
  }
}
