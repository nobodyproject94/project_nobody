import 'package:flutter/material.dart';
import 'package:project_nobody/day_1/database/preference_handler.dart';
import 'package:project_nobody/day_1/view/ghibli_screen.dart';
// import 'day_1/tugas_8_flutter_2.dart';
// import 'day_1/tugas_9_flutter.dart';
// import 'package:project_nobody/day_1/tugas_8_flutter.dart';
import 'package:project_nobody/day_1/tugas_6_flutter.dart';
// import 'package:project_nobody/day_1/tugas_7dan10_flutter.dart';

import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  await PreferenceHandler.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(
          seedColor: const Color.fromARGB(255, 146, 120, 192),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => GhibliScreen(),
        '/login': (context) => Tugas6Flutter(),
        // '/detail': (context) => const ProfilPage(),
        // '/list-category': (context) => const Tugas9Flutter(),
        //'/home': (context) => Tugas7Flutter(),
      },
      //home: Tugas8flutter(),
    );
  }
}
