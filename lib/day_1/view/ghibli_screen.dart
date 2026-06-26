import 'package:flutter/material.dart';
import 'package:project_nobody/day_1/extension/extension_navigator.dart';
import 'package:project_nobody/day_1/models/ghibli.dart';
import 'package:project_nobody/day_1/services/api_services.dart';
import 'package:project_nobody/day_1/services/dio_client.dart';
import 'package:project_nobody/day_1/view/ghibli_detail_screen.dart';

class GhibliScreen extends StatefulWidget {
  const GhibliScreen({super.key});

  @override
  State<GhibliScreen> createState() => __GhibliScreenState();
}

class __GhibliScreenState extends State<GhibliScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        // elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/ghibli icon.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ), // AppBar
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Ghibli Studio.png'),
            fit: BoxFit.fill, // Biar gambarnya memenuhi seluruh layar
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search film...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    // MENGGUNAKAN VARIABEL: Menyimpan input user ke dalam _searchQuery
                    _searchQuery = value.toLowerCase();
                  });
                },
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Ghibli>>(
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
                            const Icon(
                              Icons.wifi_off,
                              size: 64,
                              color: Colors.blueGrey,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No connection:\n${snapshot.error}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.blueGrey),
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
                  final filteredPosts = posts.where((post) {
                    return post.title.toLowerCase().contains(_searchQuery);
                  }).toList();

                  // (Opsional) Tampilkan pesan jika film yang dicari tidak ada
                  if (filteredPosts.isEmpty) {
                    return const Center(child: Text('Film tidak ditemukan.'));
                  }

                  return RefreshIndicator(
                    onRefresh: () async => _refreshPosts(),
                    child: ListView.builder(
                      itemCount: filteredPosts
                          .length, // ✅ Menggunakan data yang sudah difilter
                      itemBuilder: (context, index) {
                        final post = filteredPosts[index];

                        return Card(
                          color: Colors.white.withValues(alpha: 0.5),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(10),
                            side: BorderSide(
                              color: Colors.blueGrey.withValues(alpha: 0.2),
                              width: 1.5,
                            ),
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                post.image,
                                width: 55,
                                height: 80,
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.broken_image,
                                    size: 40,
                                    color: Colors.black,
                                  );
                                },
                              ),
                            ),
                            title: Text(
                              post.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              post.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.black),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.black,
                            ),
                            onTap: () {
                              context.push(GhibliDetailScreen(post: post));
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ), // FutureBuilder
    ); // Scaffold
  }
}
