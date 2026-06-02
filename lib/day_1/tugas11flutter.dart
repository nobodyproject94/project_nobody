import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_nobody/day_1/database/db_helper.dart';
import 'package:project_nobody/day_1/models/user_model_sql.dart';
import 'package:flutter/services.dart';
// import 'package:project_nobody/day_1/tugas11flutter.dart';
// import 'user_model_sql.dart';

class Tugas11Flutter extends StatefulWidget {
  const Tugas11Flutter({super.key});

  @override
  State<Tugas11Flutter> createState() => _Tugas11FlutterState();
}

class _Tugas11FlutterState extends State<Tugas11Flutter> {
  final _formKey = GlobalKey<FormState>();
  final DBHelper _dbHelper = DBHelper();

  // Controller untuk Form Input
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController noHpController = TextEditingController();
  final TextEditingController kotaController = TextEditingController();

  // Future untuk menampung data dari database
  late Future<List<UserModelSql>> _userList;

  @override
  void initState() {
    super.initState();
    _refreshUserList(); // Ambil data pertama kali saat aplikasi dibuka
  }

  // Fungsi untuk memperbarui list data secara real-time
  void _refreshUserList() {
    setState(() {
      _userList = _dbHelper.getAllUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TUGAS 11 - SQFLITE',
          style: TextStyle(color: Colors.amber),
        ),
        backgroundColor: const Color.fromRGBO(11, 20, 28, 1),
      ),
      backgroundColor: const Color.fromRGBO(11, 20, 28, 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ── COMPONENT 1: FORM INPUT ──────────────────────────
            Form(
              key: _formKey,
              child: Expanded(
                flex: 4, // Mengatur porsi layar untuk form
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Input Nama
                      TextFormField(
                        controller: namaController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Full name',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.person, color: Colors.white),
                        ),
                        validator: (v) =>
                            v!.isEmpty ? 'Name is required' : null,
                      ),
                      const SizedBox(height: 10),

                      // Input Email
                      TextFormField(
                        controller: emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.mail, color: Colors.white),
                        ),
                        validator: (v) =>
                            !v!.contains('@') ? 'Invalid email address' : null,
                      ),
                      const SizedBox(height: 10),

                      // Input No HP
                      TextFormField(
                        controller: noHpController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.phone, color: Colors.white),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'Phone number is required';
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(v)) {
                            return 'Only numbers are allowed';
                          }
                          if (v.length < 9) {
                            return 'Phone number too short';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),

                      // Input Asal Kota
                      TextFormField(
                        controller: kotaController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Hometown',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(
                            Icons.location_city,
                            color: Colors.white,
                          ),
                        ),
                        validator: (v) =>
                            v!.isEmpty ? 'Hometown is required' : null,
                      ),
                      const SizedBox(height: 20),

                      // Tombol Submit
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              231,
                              176,
                              9,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // 1. Buat Objek Model Baru
                              UserModelSql dataBaru = UserModelSql(
                                nama: namaController.text,
                                email: emailController.text,
                                noHp: noHpController.text,
                                asalKota: kotaController.text,
                              );

                              // 2. Simpan ke Database Lokal via DBHelper
                              bool sukses = await _dbHelper.registerUser(
                                dataBaru,
                              );

                              if (sukses) {
                                Fluttertoast.showToast(
                                  msg: "Register Succesfull!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 15,
                                );
                                // 3. Clear Form setelah sukses
                                namaController.clear();
                                emailController.clear();
                                noHpController.clear();
                                kotaController.clear();
                                // 4. Refresh List data di bawah secara real-time
                                _refreshUserList();
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Email already registered!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 15,
                                );
                              }
                            }
                          },
                          child: const Text(
                            'List of Participants',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(color: Colors.amber, thickness: 2),

            // ── COMPONENT 2: REAL-TIME LIST VIEW ─────────────────
            const Text(
              'LIST OF REGISTERED PARTICIPANTS',
              style: TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              flex: 5, // Mengatur porsi layar untuk list data
              child: FutureBuilder<List<UserModelSql>>(
                future: _userList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        'No participant have registered yet.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  // Data berhasil diambil, tampilkan lewat ListView.builder
                  final users = snapshot.data!;
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return Card(
                        color: const Color.fromRGBO(22, 32, 43, 1),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.amber,
                            child: Text(
                              user.nama[0].toUpperCase(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          title: Text(
                            user.nama,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${user.email} | ${user.noHp}\nKota: ${user.asalKota}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            onPressed: () async {
                              if (user.id != null) {
                                await _dbHelper.deleteUser(user.id!);
                                _refreshUserList(); // Refresh setelah hapus
                                Fluttertoast.showToast(
                                  msg: "Data deleted",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 15,
                                );
                              }
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
