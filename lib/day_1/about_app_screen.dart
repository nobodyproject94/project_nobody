import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:project_nobody/day_1/tugas_7_flutter.dart';
import 'package:project_nobody/day_1/tugas_8_flutter_2.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PersistentTabView(
        tabs: [
          PersistentTabConfig(
            screen: Tugas7Flutter(),
            item: ItemConfig(icon: Icon(Icons.home), title: "Home"),
          ),
          PersistentTabConfig(
            screen: Tugas8Flutter2(),
            item: ItemConfig(icon: Icon(Icons.info), title: "about app"),
          ),
        ],
        navBarBuilder: (navBarConfig) =>
            Style8BottomNavBar(navBarConfig: navBarConfig),
      ),
    );
  }
}
