import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class Tugas7Flutter extends StatefulWidget {
  final PersistentTabController? controller;
  final String? email;
  final String? password;

  // ADD TO CONSTRUCTOR
  const Tugas7Flutter({super.key, this.controller, this.email, this.password});

  @override
  State<Tugas7Flutter> createState() => _Tugas7FlutterState();
}

class _Tugas7FlutterState extends State<Tugas7Flutter> {
  bool ischeck = false;
  bool darkMode = false;
  String? selectedDropDwon;
  DateTime? selectedDate;
  TimeOfDay? selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        title: const Text('Input Interaktif'),
        centerTitle: true,
        backgroundColor: darkMode
            ? Colors.black87
            : const Color.fromARGB(255, 22, 1, 100),
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 22, 1, 100)),
              child: Column(
                children: [
                  Text(
                    'navigation menu',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  //text controller_______________________________________
                  ListTile(
                    title: Text(
                      widget.email ?? "",
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      widget.password ?? "",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.check_box),
              title: const Text('Terms and Condition'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Terms and Conditions'),
                    content: const Text(
                      'Do you agree to the terms and conditions?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            ischeck = true;
                          });
                          Navigator.pop(context);
                        },
                        child: const Text('Agree'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            ischeck = false;
                          });
                          Navigator.pop(context);
                        },
                        child: const Text('Disagree'),
                      ),
                    ],
                  ),
                );
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('Display Mode'),
              onTap: () {
                setState(() {
                  darkMode = !darkMode;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('List Category'),
              onTap: () {
                // Use the controller to jump to tab index 1
                if (widget.controller != null) {
                  widget.controller!.jumpToTab(1);
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Pick Day'),
              onTap: () async {
                Navigator.pop(context);
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? DateTime.now(),
                  firstDate: DateTime(1800),
                  lastDate: DateTime(2300),
                );
                if (picked != null) {
                  setState(() => selectedDate = picked);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.alarm),
              title: const Text('Set Reminder'),
              onTap: () async {
                Navigator.pop(context);
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: selectedDay ?? TimeOfDay.now(),
                );
                if (picked != null) {
                  setState(() => selectedDay = picked);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Detail App'),
              onTap: () {
                // Use the controller to jump to tab index 2
                if (widget.controller != null) {
                  widget.controller!.jumpToTab(2);
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  darkMode ? "Dark Mode" : "Light Mode",
                  style: TextStyle(
                    fontSize: 16,
                    color: darkMode ? Colors.amber : Colors.black,
                  ),
                ),
              ],
            ),
            // DROPDOWN
            Row(
              children: [
                DropdownButton<String>(
                  value: selectedDropDwon,
                  dropdownColor: darkMode ? Colors.grey[900] : Colors.white,
                  style: TextStyle(
                    color: darkMode ? Colors.amber : Colors.black,
                    fontSize: 16,
                  ),
                  items: ['clothing', 'shelter', 'food', 'others']
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
            // DATE PICKER
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate ?? DateTime.now(),
                      firstDate: DateTime(1800),
                      lastDate: DateTime(2300),
                    );
                    if (picked != null) {
                      setState(() => selectedDate = picked);
                    }
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Pick Date'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (selectedDate != null)
              Text(
                'Selected Date: ${selectedDate!.day.toString().padLeft(2, '0')}-'
                '${selectedDate!.month.toString().padLeft(2, '0')}-'
                '${selectedDate!.year}',
                style: TextStyle(
                  fontSize: 16,
                  color: darkMode ? Colors.amber : Colors.black,
                ),
              ),
            const SizedBox(height: 18),
            // TIME PICKER
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: selectedDay ?? TimeOfDay.now(),
                    );
                    if (picked != null) {
                      setState(() => selectedDay = picked);
                    }
                  },
                  icon: const Icon(Icons.alarm),
                  label: const Text('Set Reminder'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (selectedDay != null)
              Text(
                'Reminder set for: ${selectedDay!.hour.toString().padLeft(2, '0')}:'
                '${selectedDay!.minute.toString().padLeft(2, '0')}',
                style: TextStyle(
                  fontSize: 16,
                  color: darkMode ? Colors.amber : Colors.black,
                ),
              ),
            const SizedBox(height: 25),
            // RESULT SUMMARY
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: darkMode ? Colors.grey[800] : Colors.grey[800],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: darkMode
                      ? Colors.amber
                      : const Color.fromARGB(255, 2, 1, 100),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '📋 Status Summary',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: darkMode
                          ? Colors.white
                          : const Color.fromARGB(255, 255, 193, 7),
                    ),
                  ),
                  const Divider(),
                  Text(
                    '• Terms & Conditions: ${ischeck ? "Agreed ✅" : "Not agreed ❌"}',
                    style: TextStyle(
                      color: darkMode ? Colors.white : Colors.amber,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '• Display Mode: ${darkMode ? "Dark 🌙" : "Light ☀️"}',
                    style: TextStyle(
                      color: darkMode ? Colors.white : Colors.amber,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '• Category: ${selectedDropDwon ?? "Not selected"}',
                    style: TextStyle(
                      color: darkMode ? Colors.white : Colors.amber,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '• Selected Date: ${selectedDate != null ? "${selectedDate!.day.toString().padLeft(2, '0')}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.year}" : "Not selected"}',
                    style: TextStyle(
                      color: darkMode ? Colors.white : Colors.amber,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '• Reminder: ${selectedDay != null ? "${selectedDay!.hour.toString().padLeft(2, '0')}:${selectedDay!.minute.toString().padLeft(2, '0')}" : "Not set"}',
                    style: TextStyle(
                      color: darkMode ? Colors.white : Colors.amber,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
