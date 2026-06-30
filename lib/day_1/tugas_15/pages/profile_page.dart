import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../services/api_service.dart';
import '../../services/dio_client.dart';
import '../../services/token_services.dart';
import 'edit_profile_page.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? _user;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile({bool showLoading = true}) async {
    if (showLoading) {
      setState(() {
        _isLoading = true;
        _error = null;
      });
    }
    try {
      final dio = createDioClient();
      final apiService = ApiService(dio);
      // Token disisipkan otomatis oleh interceptor di dio_client.dart
      final response = await apiService.getProfile();

      setState(() {
        _user = response.data ?? response.user;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _logout() async {
    await TokenStorage.clearToken();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  void _refreshProfile({bool showLoading = true}) {
    _fetchProfile(showLoading: showLoading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Dashboard"),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_error != null) {
      return Center(child: Text("Error: $_error"));
    } else if (_user == null) {
      return const Center(child: Text("Data profil tidak ditemukan"));
    }

    final user = _user!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ClipOval + Image.network dengan errorBuilder:
          // Jika foto gagal dimuat (403/404/dll), tampilkan ikon fallback
          // tanpa melempar exception berulang ke console.
          ClipOval(
            child: SizedBox(
              width: 100,
              height: 100,
              child: user.profilePhoto != null && user.profilePhoto!.isNotEmpty
                  ? Image.network(
                      user.profilePhoto!.startsWith('http')
                          ? user.profilePhoto!
                          : 'https://appabsensi.mobileprojp.com/storage/${user.profilePhoto}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        debugPrint('[ProfilePhoto] Gagal memuat gambar: $error');
                        return const Icon(Icons.person, size: 50);
                      },
                    )
                  : const Icon(Icons.person, size: 50),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileItem(
                    Icons.person,
                    "Nama",
                    user.name ?? "-",
                  ),
                  const Divider(),
                  _buildProfileItem(
                    Icons.email,
                    "Email",
                    user.email ?? "-",
                  ),
                  const Divider(),
                  _buildProfileItem(
                    Icons.transgender,
                    "Jenis Kelamin",
                    user.jenisKelamin == 'L'
                        ? 'Laki-laki'
                        : (user.jenisKelamin == 'P' ? 'Perempuan' : '-'),
                  ),
                  const Divider(),
                  _buildProfileItem(
                    Icons.badge,
                    "Batch ID",
                    user.batchId?.toString() ?? "-",
                  ),
                  const Divider(),
                  _buildProfileItem(
                    Icons.school,
                    "Training ID",
                    user.trainingId?.toString() ?? "-",
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.edit),
            label: const Text("Edit Profile"),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditProfilePage(user: user),
                ),
              );
              if (result != null && result is UserModel) {
                setState(() {
                  _user = result;
                });
                _refreshProfile(showLoading: false); // Refresh to get latest photo/data silently
              } else if (result == true) {
                _refreshProfile();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueGrey),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
