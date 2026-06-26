import 'package:flutter/material.dart';
import 'package:project_nobody/day_1/models/ghibli.dart';
import 'dart:ui'; // 👈 Tambahkan ini di deretan atas

class GhibliDetailScreen extends StatefulWidget {
  final Ghibli post;

  const GhibliDetailScreen({super.key, required this.post});

  @override
  State<GhibliDetailScreen> createState() => _GhibliDetailScreenState();
}

class _GhibliDetailScreenState extends State<GhibliDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Biar background tembus ke atas AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Bikin transparan
        elevation: 0,
        // Bikin tombol panah back jadi warna putih biar kelihatan
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          // Lapis 1: Gambar Background kamu
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(widget.post.image, fit: BoxFit.fill),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // ClipRRect(
                    //   borderRadius: BorderRadiusGeometry.circular(16),
                    //   child: Image.network(
                    //     widget.post.image,
                    //     width: 200,
                    //     height: 200,
                    //     fit: BoxFit.fill,
                    //   ),
                    // ),
                    // const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(
                          alpha: 0.6,
                        ), // Hitam transparan
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withValues(
                            alpha: 0.2,
                          ), // Garis putih pudar
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.post.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const SizedBox(height: 16),
                          const Divider(color: Colors.white30), // Garis pemisah
                          const SizedBox(height: 16),

                          const Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.post.description,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
