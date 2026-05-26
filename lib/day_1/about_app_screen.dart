import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:project_nobody/day_1/tugas_7_flutter.dart';
import 'package:project_nobody/day_1/tugas_8_flutter_2.dart';
import 'package:project_nobody/day_1/tugas_9_flutter.dart';

class AboutAppScreen extends StatefulWidget {
  final String? email;
  final String? password;

  const AboutAppScreen({super.key, this.email, this.password});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        controller: _controller,
        tabs: [
          PersistentTabConfig(
            screen: Tugas7Flutter(
              controller: _controller,
              email: widget.email,
              password: widget.password,
            ), // Pass controller
            item: ItemConfig(icon: const Icon(Icons.home), title: "Home"),
          ),
          PersistentTabConfig(
            screen: Tugas9Flutter(),
            item: ItemConfig(
              icon: const Icon(Icons.category),
              title: "List Category",
            ),
          ),
          PersistentTabConfig(
            screen: Tugas8Flutter2(),
            item: ItemConfig(icon: const Icon(Icons.info), title: "About App"),
          ),
        ],
        navBarBuilder: (navBarConfig) =>
            Style8BottomNavBar(navBarConfig: navBarConfig),
      ),
    );
  }
}
