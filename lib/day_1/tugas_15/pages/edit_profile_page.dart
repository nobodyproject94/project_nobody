import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import '../../models/user_model.dart';
import '../../services/api_service.dart';
import '../../services/dio_client.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel user;

  const EditProfilePage({super.key, required this.user});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _batchIdController;
  late TextEditingController _trainingIdController;
  late String _jenisKelamin;
  bool _isLoading = false;
  String? _base64Image;
  File? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await File(pickedFile.path).readAsBytes();
      setState(() {
        _imageFile = File(pickedFile.path);
        _base64Image = "data:image/png;base64,${base64Encode(bytes)}";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name ?? '');
    _emailController = TextEditingController(text: widget.user.email ?? '');
    _passwordController = TextEditingController();
    _batchIdController = TextEditingController(
      text: widget.user.batchId?.toString() ?? '1',
    );
    _trainingIdController = TextEditingController(
      text: widget.user.trainingId?.toString() ?? '1',
    );
    _jenisKelamin =
        (widget.user.jenisKelamin == 'L' || widget.user.jenisKelamin == 'P')
        ? widget.user.jenisKelamin!
        : 'L';
  }

  void _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final dio = createDioClient();
      final apiService = ApiService(dio);

      // ── 1. Update nama ────────────────────────────────────────────────────
      // PUT /api/profile hanya menerima field "name".
      // Field lain (email, jenis_kelamin, dll) TIDAK didukung → 422.
      final body = <String, dynamic>{
        'name': _nameController.text.trim(),
      };

      debugPrint('--> Update profile body: $body');
      final response = await apiService.updateProfile(body);
      debugPrint('<-- Update profile response: ${response.message} | '
          'user=${response.data?.name ?? response.user?.name}');

      // ── 2. Update foto (jika ada gambar baru dipilih) ────────────────────
      if (_base64Image != null) {
        final photoBody = <String, dynamic>{
          'profile_photo': _base64Image!,
        };
        debugPrint('--> Update photo body: { profile_photo: [base64 data...] }');
        final photoResponse = await apiService.updateProfilePhoto(photoBody);
        debugPrint('<-- Update photo response: ${photoResponse.message}');
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile berhasil diupdate!')),
      );

      final UserModel updatedUser = UserModel(
        id: widget.user.id,
        name: _nameController.text.trim(),
        email: widget.user.email,
        jenisKelamin: widget.user.jenisKelamin,
        batchId: widget.user.batchId,
        trainingId: widget.user.trainingId,
        profilePhoto: widget.user.profilePhoto,
      );

      Navigator.pop(context, updatedUser);

    } on DioException catch (e) {
      debugPrint('XXX Update profile error: ${e.response?.statusCode} '
          '${e.response?.data}');
      String errorMessage = 'Gagal update profile: Terjadi kesalahan jaringan.';
      if (e.response != null) {
        if (e.response!.statusCode == 422) {
          final errors = e.response?.data['errors'];
          final msg = e.response?.data['message'];
          if (errors != null) {
            errorMessage = 'Gagal update profile (422): $errors';
          } else if (msg != null) {
            errorMessage = 'Gagal update profile (422): $msg';
          } else {
            errorMessage = 'Gagal update profile: Data tidak valid (422).';
          }
        } else if (e.response!.statusCode == 401) {
          errorMessage = 'Gagal update profile: Sesi habis, silakan login ulang.';
        } else if (e.response!.statusCode == 500) {
          errorMessage = 'Gagal update profile: Terjadi kesalahan pada server (500).';
        } else {
          errorMessage = 'Gagal update profile (${e.response!.statusCode}): '
              '${e.response?.data['message'] ?? e.message}';
        }
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e, st) {
      debugPrint('XXX Update profile exception: $e\n$st');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal update profile: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        // Gunakan ClipOval + Image.network dengan errorBuilder
                        // agar error 403/404 dari server ditampilkan sebagai
                        // fallback icon — tidak melempar exception ke console.
                        ClipOval(
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: _imageFile != null
                                // Foto baru dari galeri — tampil dari file lokal
                                ? Image.file(
                                    _imageFile!,
                                    fit: BoxFit.cover,
                                  )
                                : (widget.user.profilePhoto != null &&
                                        widget.user.profilePhoto!.isNotEmpty
                                    // Foto dari server — pakai errorBuilder agar
                                    // 403/404 tidak crash
                                    ? Image.network(
                                        widget.user.profilePhoto!.startsWith('http')
                                            ? widget.user.profilePhoto!
                                            : 'https://appabsensi.mobileprojp.com/storage/${widget.user.profilePhoto}',
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          debugPrint('[ProfilePhoto] Gagal memuat gambar: $error');
                                          return const Icon(Icons.person, size: 50);
                                        },
                                      )
                                    // Tidak ada foto — tampil icon default
                                    : const Icon(Icons.person, size: 50)),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.person),
                    ),
                    validator: (val) => val!.isEmpty ? "Nama tidak boleh kosong" : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.email),
                    ),
                    validator: (val) => val!.isEmpty ? "Email tidak boleh kosong" : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password (Kosongkan jika tidak diubah)",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: _jenisKelamin,
                    decoration: InputDecoration(
                      labelText: "Jenis Kelamin",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.transgender),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'L', child: Text('Laki-laki')),
                      DropdownMenuItem(value: 'P', child: Text('Perempuan')),
                    ],
                    onChanged: (val) => setState(() => _jenisKelamin = val!),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _batchIdController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Batch ID",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.badge),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _trainingIdController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Training ID",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.school),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _updateProfile,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _isLoading
                        ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : const Text("Save Changes", style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
