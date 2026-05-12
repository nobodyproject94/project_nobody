import 'package:flutter/material.dart';

class TugasFlutter3 extends StatelessWidget {
  const TugasFlutter3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registration and Catalog',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 26, 35, 126),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Registration Form',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 26, 35, 126),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.people),
              ),
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            const TextField(
              obscureText: true,
              obscuringCharacter: '.',
              decoration: InputDecoration(
                labelText: 'Pasword',
                hintText: 'Enter your password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 10),
            const TextField(
              obscureText: true,
              obscuringCharacter: '.',
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Confirm your password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Phone',
                hintText: 'Enter your number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Type your description',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.notes),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            const Text(
              'Catalog',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Image.asset('assets/images/audi.jpg', fit: BoxFit.cover),
                Image.asset(
                  'assets/images/ford_ranger.avif',
                  fit: BoxFit.cover,
                ),
                Image.asset('assets/images/g class.jpg', fit: BoxFit.cover),
                Image.asset('assets/images/lc toyota.jpg', fit: BoxFit.cover),
                Image.asset('assets/images/mini cooper.jpg', fit: BoxFit.cover),
                Image.asset('assets/images/vw.jpg', fit: BoxFit.cover),
              ],
            ),
            Stack(
              alignment: AlignmentGeometry.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 10,
                  width: 10,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.indigo[900],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Positioned.fill(
                  bottom: 5,
                  left: 5,
                  right: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 100,
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 26, 35, 126),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      'lebel',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
