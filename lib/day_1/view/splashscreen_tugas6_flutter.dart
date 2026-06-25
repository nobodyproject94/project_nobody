import 'package:flutter/material.dart';
import 'package:project_nobody/day_1/extension/extension_navigator.dart';
import 'package:project_nobody/day_1/view/ghibli_screen.dart';
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
    await Future.delayed(const Duration(seconds: 2)); // tampilkan logo 2 detik

    //final isLoggedIn = PreferenceHandler.isLogin;

    if (!mounted) return;
    context.pushAndRemoveAll(GhibliScreen());

    // if (isLoggedIn) {
    //   context.pushAndRemoveAll(GhibliScreen());
    // } else {
    //   context.pushAndRemoveAll(Tugas6Flutter());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/ghibli logo.png',
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
