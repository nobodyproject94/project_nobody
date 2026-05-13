import 'package:flutter/material.dart';

class Tugas2flutter extends StatelessWidget {
  const Tugas2flutter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil Toko',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 1, 46, 97),
        ),
        useMaterial3: true,
      ),
      home: const ProfilPage(),
    );
  }
}

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ─────────────────────────────────────────────
      // 1. HEADER (AppBar) — relevan dengan tema toko
      // ─────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 46, 97),
        foregroundColor: Colors.white,
        title: const Text(
          'Detail App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 4,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─────────────────────────────────────────
            // 2. IDENTITAS UTAMA — Center + nama toko
            // ─────────────────────────────────────────
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: const Color.fromARGB(255, 1, 46, 97),
                    child: const Icon(
                      Icons.store,
                      size: 52,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'MaestroNesia',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(0, 0, 0, 255),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Verified Merchant ✓',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ─────────────────────────────────────────
            // 3. DETAIL KONTAK — Container + Padding
            //    Row berisi Icon, SizedBox, Text
            // ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color.fromARGB(0, 0, 0, 255)),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informasi Kontak',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1565C0),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        Icon(Icons.email, color: Color(0xFF1565C0), size: 20),
                        SizedBox(width: 10), // SizedBox sebagai jarak
                        Text(
                          'admin@MaestroNesia.com',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: const [
                        Icon(
                          Icons.language,
                          color: Color(0xFF1565C0),
                          size: 20,
                        ),
                        SizedBox(width: 10), // SizedBox sebagai jarak
                        Text(
                          'www.MaestroNesia.co.id',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ─────────────────────────────────────────
            // 4. INFORMASI PENDUKUNG — Row + Spacer
            //    Spacer mendorong elemen ke kanan
            // ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: const [
                  Icon(Icons.phone, color: Colors.green, size: 20),
                  SizedBox(width: 6),
                  Text('0812-3456-7890', style: TextStyle(fontSize: 15)),
                  Spacer(), // Spacer mendorong elemen berikut ke kanan
                  Icon(Icons.location_on, color: Colors.red, size: 20),
                  SizedBox(width: 4),
                  Text('Indonesia', style: TextStyle(fontSize: 15)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ─────────────────────────────────────────
            // 5. STATISTIK HORIZONTAL — Row + Expanded
            //    Setiap Container dibungkus Expanded
            // ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Kotak Statistik 1 — Produk Terjual
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1565C0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            '12.4K',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Sold Product',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Kotak Statistik 2 — Rating
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 4, right: 4),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF57F17),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            '4.9 ★',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Rate Store',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Kotak Statistik 3 — Followers
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E7D32),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            '8.2K',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Followers',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ─────────────────────────────────────────
            // SizedBox + Padding
            // ─────────────────────────────────────────
            const SizedBox(height: 24), // SizedBox jarak vertikal
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ), // inner spacing
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About App',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1565C0),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Welcome to Maestro, the revolutionary platform that connects you instantly with specialized experts through live voice and video calls.'
                    'We believe that the best knowledge is not always found in manuals it is stored in the minds of experts who have spent years mastering their craft.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            // ─────────────────────────────────────────
            //Container dekoratif
            // ─────────────────────────────────────────
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.verified_user,
                      color: Colors.white,
                      size: 36,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'MAESTRONESIA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        Text(
                          'Trusted Consultation East. 2026',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
