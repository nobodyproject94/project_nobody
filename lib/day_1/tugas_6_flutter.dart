import 'package:flutter/material.dart';
import 'package:project_nobody/day_1/extension/extension_navigator.dart';
import 'package:project_nobody/day_1/tugas_4_flutter.dart';
import 'package:project_nobody/day_1/tugas_5_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Tugas6Flutter extends StatefulWidget {
  const Tugas6Flutter({super.key});

  @override
  State<Tugas6Flutter> createState() => _Tugas6FlutterState();
}

class _Tugas6FlutterState extends State<Tugas6Flutter> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'MAESTRONESIA',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 231, 176, 9),
              ),
            ),
            SizedBox(height: 4),
            Text(
              'SOLUSI, AKURASI, KEAHLIAN',
              style: TextStyle(
                color: Color.fromARGB(255, 231, 176, 9),
                fontSize: 11,
                letterSpacing: 2.3,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(11, 20, 28, 1),
      ),
      backgroundColor: const Color.fromRGBO(11, 20, 28, 1),
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ── EMAIL ──────────────────────────
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'enter your email',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.mail, color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'email is required';
                    }
                    if (!value.contains('@')) {
                      return 'Invalid email format';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // ── PASSWORD ───────────────────────
                TextFormField(
                  obscureText: _obscurePassword,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'enter your password',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Colors.amberAccent,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword =
                              !_obscurePassword; // toggle show/hide
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'password is required';
                    }
                    if (value.length < 8) {
                      return 'Enter at least 8 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                // ── TOMBOL LOGIN ───────────────────
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 231, 176, 9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Success"),
                              content: const Text("Log in succesfully"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    context.push(Tugas5Flutter());
                                  },
                                  child: const Text("Continue"),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: "Please check your input again",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15,
                        );
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(
                        //     content: Text('Please check your input again'),
                        //     backgroundColor: Colors.red,
                        //     behavior: SnackBarBehavior.floating,
                        //     duration: Duration(seconds: 1, milliseconds: 500),
                        //   ),
                        // );
                      }
                    },

                    child: const Text(
                      'Log In',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                const Text(
                  'or Sign up with',
                  style: TextStyle(color: Color.fromARGB(255, 231, 176, 9)),
                ),

                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Tombol Google
                    ElevatedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                      onPressed: () {
                        // Aksi tombol Google
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('assets/images/google.png', width: 20),
                          const SizedBox(width: 8),
                          const Text(
                            'Google',
                            style: TextStyle(
                              color: Color.fromRGBO(11, 20, 28, 1),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),

                    // Tombol LinkedIn
                    ElevatedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/images/LinkedIn.png',
                        width: 20,
                      ),
                      label: const Text(
                        'LinkedIn',
                        style: TextStyle(
                          color: Color.fromRGBO(11, 20, 28, 1),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.push(Tugas4Flutter());
                      },
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          color: Color.fromARGB(255, 231, 176, 9),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
