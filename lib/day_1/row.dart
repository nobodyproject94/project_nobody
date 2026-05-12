import 'package:flutter/material.dart';

class Row extends StatelessWidget {
  const Row({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ford Ranger")),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(15),
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/ford_ranger.avif"),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            spacing: 5,
            children: [
              Text(
                "saldo kebanyakan",
                style: TextStyle(color: Colors.red, fontSize: 23),
              ),
              Text(
                "bayar",
                style: TextStyle(
                  fontSize: 23,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline,
                ),
              ),
              Text("Top Up"),
              Text("Explore"),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            spacing: 5,
            children: [
              Text("saldo kebanyakan"),
              Text("bayar"),
              Text("Top Up"),
              Text("Explore"),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            spacing: 5,
            children: [
              Text("saldo kebanyakan"),
              Text("bayar"),
              Text("Top Up"),
              Text("Explore"),
            ],
          ),
        ],
      ),
    );
  }
}
