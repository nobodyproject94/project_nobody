import 'package:flutter/material.dart';
import 'package:project_nobody/day_1/models/ghibli.dart';
import 'package:project_nobody/day_1/services/api_services.dart';
import 'package:project_nobody/day_1/services/dio_client.dart';

class GhibliScreen extends StatefulWidget {
  const GhibliScreen({super.key});

  @override
  State<GhibliScreen> createState() => __GhibliScreenState();
}

class __GhibliScreenState extends State<GhibliScreen> {
  late final ApiService _apiService;
  late Future<List<Ghibli>> _postsFuture;

  @override
  void initState() {
    super.initState();
    final dio = createDioClient();
    _apiService = ApiService(dio);
    _postsFuture = _apiService.getFilms();
  }

  void _refreshPosts() {
    setState(() {
      _postsFuture = _apiService.getFilms();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        // iconTheme: const IconThemeData(color: Colors.white),
      ), // AppBar
      body: FutureBuilder<List<Ghibli>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      'No connection:\n${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ), // Text
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _refreshPosts,
                      child: const Text('Try again'),
                    ), // ElevatedButton
                  ],
                ), // Column
              ), // Padding
            ); // Center
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data post.'));
          }

          final posts = snapshot.data!;

          return RefreshIndicator(
            onRefresh: () async => _refreshPosts(),
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ), // EdgeInsets.symmetric
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        post.image,
                        width: 55,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.broken_image,
                            size: 40,
                            color: Colors.grey,
                          );
                        },
                      ), // TextStyle
                    ), // CircleAvatar
                    title: Text(
                      post.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ), // Text
                    subtitle: Text(
                      post.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ), // Text
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ), // ListTile
                ); // Card
              },
            ), // ListView.builder
          ); // RefreshIndicator
        },
      ), // FutureBuilder
    ); // Scaffold
  }
}
