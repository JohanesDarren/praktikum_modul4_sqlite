import 'package:flutter/material.dart';
import 'saham.dart';
import 'koneksi.dart';
import 'detail_buku.dart';

class ListSaham extends StatefulWidget {
  const ListSaham({super.key});

  @override
  State<ListSaham> createState() => _ListSahamState();
}

class _ListSahamState extends State<ListSaham> {
  List<Saham> daftarSaham = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Saham"),
      ),
      body: FutureBuilder<List<Saham>>(
        future: SahamQueryHandler().ambilSemuaSaham(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
              daftarSaham = snapshot.data!;

              return ListView.builder(
                  itemCount: daftarSaham.length,
                  itemBuilder: (context, index){
                    final saham = daftarSaham[index];
                    return ListTile(
                      title: Text(saham.ticker),
                      subtitle: Text('Open: ${saham.open} | High: ${saham.high} | Last: ${saham.last} | Change: ${saham.change}%'),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailSaham(saham: saham)),
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
