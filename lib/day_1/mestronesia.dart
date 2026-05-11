import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 9, 49),
      appBar: AppBar(
        title: Text('MaestroNesia'),
        titleTextStyle: TextStyle(color: Colors.lightGreenAccent, fontSize: 25),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 2, 9, 49),
      ),
      body: Column(children: [
        
      ],),
    );
  }
}
