import 'package:flutter/material.dart';

class Layouting extends StatelessWidget {
  const Layouting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ThreatLab"),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 30,
        ),
        backgroundColor: Colors.white70,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(
            'My Own Bussines',
            style: TextStyle(fontSize: 20, color: Colors.indigo),
          ),
          SizedBox(height: 20),
          SizedBox(width: 15),
          Row(mainAxisAlignment: MainAxisAlignment.center),
          Row(children: [Text('product')]),
        ],
      ),
    );
  }
}
