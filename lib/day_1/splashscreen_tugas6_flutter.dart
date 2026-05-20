import 'package:flutter/material.dart';
import 'package:project_nobody/day_1/extension/extension_navigator.dart';
import 'package:project_nobody/day_1/tugas_6_flutter.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(11, 20, 28, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/images/maestronesialogo.png')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 231, 176, 9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              // context.pushNamed("/login");
              // context.push(Textrich());
              context.push(Tugas6Flutter());
            },
            child: Text(
              'Begin your journey',
              style: TextStyle(color: const Color.fromRGBO(11, 20, 28, 1)),
            ),
          ),
        ],
      ),
    );
  }
}
