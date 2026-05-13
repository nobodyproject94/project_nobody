import 'package:flutter/material.dart';

class Tugas4Flutter extends StatelessWidget {
  const Tugas4Flutter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        title: Text('Cutomer Data Management'),
        centerTitle: true,
        backgroundColor: Colors.indigo[900],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(15),
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Name',
              hintText: 'Enter your name',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          SizedBox(height: 5),
          TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
          ),
          SizedBox(height: 5),
          TextField(
            obscureText: true,
            obscuringCharacter: '_',
            decoration: InputDecoration(
              labelText: 'Passowrd',
              hintText: 'Enter your password',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock),
            ),
          ),
          SizedBox(height: 5),
          TextField(
            decoration: InputDecoration(
              labelText: 'Phone',
              hintText: 'Enter your number',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.phone),
            ),
          ),
          SizedBox(height: 5),
          TextField(
            decoration: InputDecoration(border: UnderlineInputBorder()),
          ),
          SizedBox(height: 5),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    "assets/images/ford_ranger.avif",
                    width: 45, // ✅ tambah ukuran
                    height: 45, // ✅ tambah ukuran
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text('Ford Ranger'),
                subtitle: Text('Ford'),
                trailing: Icon(Icons.play_arrow),
              );
            },
          ),
        ],
      ),
    );
  }
}
