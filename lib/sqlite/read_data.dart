import 'package:flutter/material.dart';
import 'buku.dart';
import 'koneksi.dart';
import 'detail_buku.dart';

class ListBuku extends StatefulWidget {
  const ListBuku({super.key});

  @override
  State<ListBuku> createState() => _ListBukuState();
}

class _ListBukuState extends State<ListBuku> {
  List<Buku> daftarBuku = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contoh List Buku"),
      ),
      body: FutureBuilder<List<Buku>>(
        future: BukuQueryHandler().ambilSemuaBuku(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
              daftarBuku = snapshot.data!;

              return ListView.builder(
                  itemCount: daftarBuku.length,
                  itemBuilder: (context, index){
                    final buku = daftarBuku[index];
                    return ListTile(
                      title: Text(buku.nama_buku),
                      subtitle: Text(buku.isbn.toString()),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailBuku(buku: buku)),
                        );
                      },
                    );
                  }
              );
          }
        }
      ),
    );
  }
}
