import 'package:flutter/material.dart';
import 'buku.dart';

class DetailBuku extends StatefulWidget {
  final Buku buku;

  const DetailBuku({super.key, required this.buku});

  @override
  State<DetailBuku> createState() => _DetailBukuState();

}

class _DetailBukuState extends State<DetailBuku> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Buku"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(widget.buku.nama_buku),
            Text(widget.buku.isbn.toString()),
          ],
        )
      )
    );
  }
}
