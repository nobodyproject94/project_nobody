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

  // Variabel untuk Filter Kategori (Genre)
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Magic',
    'War',
    'Family',
    'Nature',
    'Girl',
  ];

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Ghibli Studio.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // --- 1. SEARCH BAR ---
              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 12,
                  bottom: 8,
                ),
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
                      _searchQuery = value.toLowerCase();
                    });
                  },
                ),
              ),

              // --- 2. KATEGORI FILTER (CHIPS) ---
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    final isSelected = _selectedCategory == category;

                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: isSelected,
                        selectedColor: Colors.blueAccent,
                        backgroundColor: Colors.black.withValues(alpha: 0.5),
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.white,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        side: BorderSide(
                          color: isSelected
                              ? Colors.blueAccent
                              : Colors.white.withValues(alpha: 0.2),
                        ),
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),

              // --- 3. AREA LIST FILM (GRID) ---
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
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: _refreshPosts,
                                child: const Text('Try again'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text(
                          'Tidak ada data post.',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    // --- LOGIKA FILTER PENCARIAN & KATEGORI ---
                    final posts = snapshot.data!;
                    final filteredPosts = posts.where((post) {
                      final matchesSearch = post.title.toLowerCase().contains(
                        _searchQuery,
                      );
                      final matchesCategory =
                          _selectedCategory == 'All' ||
                          post.description.toLowerCase().contains(
                            _selectedCategory.toLowerCase(),
                          );

                      return matchesSearch && matchesCategory;
                    }).toList();

                    if (filteredPosts.isEmpty) {
                      return const Center(
                        child: Text(
                          'Film tidak ditemukan.',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    // --- GRIDVIEW DENGAN REFRESH INDICATOR ---
                    return RefreshIndicator(
                      onRefresh: () async => _refreshPosts(),
                      child: GridView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(
                          top: 0,
                          bottom: 20,
                          left: 12,
                          right: 12,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.53,
                            ),
                        itemCount: filteredPosts.length,
                        itemBuilder: (context, index) {
                          final post = filteredPosts[index];

                          return Card(
                            color: Colors.black.withValues(alpha: 0.7),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: Colors.white.withValues(alpha: 0.1),
                                width: 1,
                              ),
                            ),
                            clipBehavior: Clip.antiAlias,

                            child: InkWell(
                              onTap: () {
                                context.push(GhibliDetailScreen(post: post));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      post.image,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return const Icon(
                                              Icons.broken_image,
                                              color: Colors.grey,
                                            );
                                          },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 14,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              '8.5',
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          post.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 10),

                                        SizedBox(
                                          width: double.infinity,
                                          height: 34,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white
                                                  .withValues(alpha: 0.15),
                                              foregroundColor: Colors.white,
                                              elevation: 0,
                                              padding: EdgeInsets.zero,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            onPressed: () {
                                              context.push(
                                                GhibliDetailScreen(post: post),
                                              );
                                            },
                                            child: const Text(
                                              'Play',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
        ),
      ),
    );
  }
}
