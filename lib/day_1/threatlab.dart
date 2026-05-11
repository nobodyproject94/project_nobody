import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("ThreatLab"),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 30,
        ),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(
            'My Own Bussines',
            style: TextStyle(fontSize: 20, color: Colors.indigo, fontStyle: ),
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
