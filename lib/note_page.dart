import 'package:flutter/material.dart';
import 'package:prak3/sidemenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final TextEditingController _noteController = TextEditingController();
  String? _savedNote;

  @override
  void initState() {
    super.initState();
    _loadNote();
  }

  void _loadNote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedNote = prefs.getString('note');
    });
  }

  void _saveNote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('note', _noteController.text);
    setState(() {
      _savedNote = _noteController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
      drawer: const Sidemenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: TextField(
                controller: _noteController,
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: 'Write Your Notes',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Tombol Simpan yang dimodifikasi
            ElevatedButton(
              onPressed: _saveNote,
              child: const Text(
                'Save Notes', // Ubah tulisan tombol
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white), // Warna teks putih
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 32), // Padding horizontal ditambahkan
                backgroundColor: Colors.blue, // Warna tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5, // Bayangan tombol
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _savedNote != null
                  ? Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blueAccent, width: 1),
                      ),
                      child: Text(
                        'saved records:\n\n$_savedNote',
                        style: const TextStyle(fontSize: 18),
                      ),
                    )
                  : const Text('No record saved'),
            ),
          ],
        ),
      ),
    );
  }
}
