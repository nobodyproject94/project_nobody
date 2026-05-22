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
                    color: darkMode
                        ? Colors.amber
                        : const Color.fromARGB(255, 2, 1, 100),
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
            //DATE TIME
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
                      {}
                    }
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('pick date'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (selectedDate != null)
              Text(
                'Date of Birth: ${selectedDate!.day.toString().padLeft(2, '0')}-'
                '${selectedDate!.month.toString().padLeft(2, '0')}-'
                '${selectedDate!.year}',
                style: TextStyle(
                  fontSize: 16,
                  color: darkMode ? Colors.amber : Colors.black,
                ),
              ),
            const SizedBox(height: 18),
            // time picker
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
                      {}
                    }
                  },
                  icon: const Icon(Icons.alarm),
                  label: const Text('set reminder'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (selectedDay != null)
              Text(
                'A reminder has been set for:'
                '${selectedDay!.hour.toString().padLeft(2, '0')}:'
                '${selectedDay!.minute.toString().padLeft(2, '0')}',
                style: TextStyle(
                  fontSize: 16,
                  color: darkMode ? Colors.amber : Colors.black,
                ),
              ),
            const SizedBox(height: 25),
            //RESULT
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
                    '📋 status summary',
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
                    '• terms & conditions: ${ischeck ? "Registration is allowed ✅" : "Registration is not yet open ❌"}',
                    style: TextStyle(
                      color: darkMode ? Colors.white : Colors.amber,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '• display mode: ${darkMode ? "dark 🌙" : "light ☀️"}',
                    style: TextStyle(
                      color: darkMode ? Colors.white : Colors.amber,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '• category: ${selectedDropDwon ?? "Not yet selected"}',
                    style: TextStyle(
                      color: darkMode ? Colors.white : Colors.amber,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '• date of birth: ${selectedDate != null ? "${selectedDate!.day.toString().padLeft(2, '0')}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.year}" : "Belum dipilih"}',
                    style: TextStyle(
                      color: darkMode ? Colors.white : Colors.amber,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '• reminder: ${selectedDay != null ? "${selectedDay!.hour.toString().padLeft(2, '0')}:${selectedDay!.minute.toString().padLeft(2, '0')}" : "Belum diatur"}',
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
