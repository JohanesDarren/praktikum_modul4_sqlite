import 'package:flutter/material.dart';
import 'koneksi.dart';
import 'buku.dart';
import 'read_data.dart';

class InputBuku extends StatelessWidget {

  InputBuku({super.key});

  final TextEditingController _namaBukuController = TextEditingController();
  final TextEditingController _isbnController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contoh Shared Preference"),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _namaBukuController,
              decoration: InputDecoration(
                labelText: 'Nama Buku',
              ),
            ),
            TextField(
              controller: _isbnController,
              decoration: InputDecoration(
                labelText: 'ISBN',
              ),
            ),
            TextButton(
                onPressed: (){
                  final buku = Buku(
                    nama_buku: _namaBukuController.text,
                    isbn: int.parse(_isbnController.text),
                  );

                  BukuQueryHandler()
                      .tambahBuku(_namaBukuController.text, int.parse(_isbnController.text));

                  _namaBukuController.clear();
                  _isbnController.clear();
                },
                child: Text("Simpan Buku")
            ),
            TextButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListBuku()),
              );
            }, child: Text("Lihat Buku"))
          ],
        ),
      ),
    );
  }
}
