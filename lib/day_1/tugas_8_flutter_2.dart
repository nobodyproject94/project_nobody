import 'package:flutter/material.dart';

class Tugas8Flutter2 extends StatefulWidget {
  const Tugas8Flutter2({super.key});

  @override
  State<Tugas8Flutter2> createState() => _Tugas8Flutter2gas5FlutterState();
}

class _Tugas8Flutter2gas5FlutterState extends State<Tugas8Flutter2> {
  bool showSecret = false;
  bool isLiked = false;
  bool showDeskripsi = false;
  String pesanInkWell = '';
  int nilaiCounter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AboutApp',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 22, 1, 100),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 22, 1, 100),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                setState(() => showSecret = !showSecret);
              },
              child: Text(showSecret ? 'Hide' : 'Show'),
            ),
            if (showSecret)
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color.fromARGB(255, 22, 1, 100),
                  ),
                ),
                child: const Text('MaestroNesia'),
              ),
            const Divider(height: 32),
            Row(
              children: [
                IconButton(
                  iconSize: 36,
                  onPressed: () {
                    setState(() => isLiked = !isLiked);
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: isLiked ? Colors.red : Colors.grey,
                  ),
                ),
                Text(
                  isLiked ? '❤️ like!' : 'dislike',
                  style: TextStyle(color: isLiked ? Colors.red : Colors.grey),
                ),
                const Divider(height: 30),
              ],
            ),
            TextButton.icon(
              onPressed: () {
                setState(() => showDeskripsi = !showDeskripsi);
              },
              icon: Icon(showDeskripsi ? Icons.expand_less : Icons.expand_more),
              label: Text(showDeskripsi ? 'Hide' : 'Show'),
            ),
            if (showDeskripsi)
              Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 22, 1, 100),
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(
                    color: const Color.fromARGB(255, 22, 1, 100),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: Image.asset(
                    'assets/images/ford_ranger.avif',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const Divider(height: 30),
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                setState(() {
                  setState(() => pesanInkWell = '✅ detection!');
                  debugPrint('detection');
                });
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 22, 1, 100),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const SizedBox(
                  height: 80,
                  child: Center(
                    child: Text(
                      'Ford Ranger',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (pesanInkWell.isNotEmpty)
              Padding(
                padding: const EdgeInsetsGeometry.only(top: 8),
                child: Text(
                  pesanInkWell,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 22, 1, 100),
                  ),
                ),
              ),
            const Divider(height: 30),
            Text(
              'Counter: $nilaiCounter',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                setState(() => nilaiCounter += 1);
                debugPrint('Ditekan sekali');
              },
              onDoubleTap: () {
                setState(() => nilaiCounter += 2);
                debugPrint('Ditekan dua kali');
              },
              onLongPress: () {
                setState(() => nilaiCounter += 3);
                debugPrint('Tahan lama');
              },
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 22, 1, 100),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Tap / Double Tap / Long Press',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
