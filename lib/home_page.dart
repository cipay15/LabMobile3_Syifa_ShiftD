import 'package:flutter/material.dart';
import 'package:prak3/sidemenu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'note_page.dart'; // Import halaman notes

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var namauser = 'Hefay'; // Default value sementara

  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      namauser = prefs.getString('username') ??
          'User'; // Default 'User' jika tidak ditemukan
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.blue, // Latar belakang biru untuk AppBar
          ),
        ),
        title: const Text(
          'myNotes',
          style: TextStyle(color: Colors.white), // Warna teks di AppBar
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Mengatur warna ikon menjadi putih
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Elemen berada di tengah vertikal
          crossAxisAlignment:
              CrossAxisAlignment.center, // Elemen berada di tengah horizontal
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Welcome Back, $namauser!',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Please Add Your Note according to your activities!',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Navigasi ke halaman NotePage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotePage()),
                );
              },
              icon: const Icon(Icons.add,
                  size: 24, color: Colors.white), // Ikon "+" warna putih
              label: const Text(
                'Add Notes',
                style: TextStyle(
                    fontSize: 18, color: Colors.white), // Teks warna putih
              ), // Tulisan "Add Notes"
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                backgroundColor: Colors.blue, // Warna tombol
                foregroundColor: Colors.white, // Warna teks dan ikon putih
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(30), // Membuat tombol bulat
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: const Sidemenu(),
    );
  }
}
