import 'package:flutter/material.dart';
import 'package:project_nobody/day_1/database/preference_handler.dart';
import 'package:project_nobody/day_1/extension/extension_navigator.dart';
import 'package:project_nobody/day_1/tugas_6_flutter.dart';
import 'package:project_nobody/day_1/tugas_7dan10_flutter.dart';
// import 'package:project_nobody/day_1/tugas11flutter.dart';
// home screen

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3)); // tampilkan logo 2 detik

    final isLoggedIn = PreferenceHandler.isLogin;

    if (!mounted) return;

    if (isLoggedIn) {
      context.pushAndRemoveAll(Tugas7Flutter());
    } else {
      context.pushAndRemoveAll(Tugas6Flutter());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(11, 20, 28, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/maestronesialogo.png'),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              color: Color.fromARGB(255, 231, 176, 9),
            ),
          ],
        ),
      ),
    );
  }
}
