import 'package:flutter/material.dart';

class Tugas7Flutter extends StatefulWidget {
  const Tugas7Flutter({super.key});

  @override
  State<Tugas7Flutter> createState() => _Tugas7FlutterState();
}

class _Tugas7FlutterState extends State<Tugas7Flutter> {
  bool ischeck = false;
  bool darkMode = false;
  String? selectedDropDwon;
  DateTime? selectedDate;
  TimeOfDay? selctedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        title: const Text('Input Interaktif'),
        backgroundColor: darkMode
            ? Colors.black87
            : const Color.fromARGB(255, 22, 1, 100),
        foregroundColor: Colors.white,
      ),
      //drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 22, 1, 100)),
              child: Text(
                'navigation menu',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.check_box),
              title: const Text('terms and condition'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('display mode'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('product category'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('pick day'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.alarm),
              title: const Text('set reminder'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      //body
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                //CHECKING
                Checkbox(
                  value: ischeck,
                  onChanged: (value) {
                    setState(() => ischeck = value ?? false);
                  },
                ),
                const SizedBox(width: 10),
                Text(
                  ischeck ? "agreed" : "disagreed",
                  style: TextStyle(
                    fontSize: 16,
                    color: darkMode ? Colors.amber : Colors.black,
                  ),
                ),
              ],
            ),
            // SWITCHING
            Row(
              children: [
                Switch(
                  value: darkMode,
                  onChanged: (value) {
                    setState(() => darkMode = value);
                  },
                ),
                const SizedBox(width: 10),
                Text(
                  darkMode ? "off" : "on",
                  style: TextStyle(
                    fontSize: 16,
                    color: darkMode ? Colors.amber : Colors.black,
                  ),
                ),
              ],
            ),
            //DROP BOTTON
            Row(
              children: [
                DropdownButton<String>(
                  value: selectedDropDwon,
                  items: ['Elektronik', 'Pakaian', 'Makanan', 'Lainnya']
                      .map(
                        (item) =>
                            DropdownMenuItem(value: item, child: Text(item)),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() => selectedDropDwon = value!);
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
            //DATE TIME
            Row(),
          ],
        ),
      ),
    );
  }
}
