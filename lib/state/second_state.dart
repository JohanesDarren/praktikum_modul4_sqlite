import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'keranjang_provider.dart';
import 'third_page.dart';
import 'wishlist_provider.dart';

class SecondState extends StatefulWidget {
  SecondState({super.key});

  @override
  State<SecondState> createState() => _SecondStateState();
}

class _SecondStateState extends State<SecondState> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Simple State"),
          ),
          body: Column(
            children: [
              const Text("Angkat"),
              Consumer<KeranjangProvider>(
                builder: (context, counterProvider, child) {
                  return Text("Jumlah item keranjang ${counterProvider.keranjangCount}");
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<KeranjangProvider>().increment();
                  },
                  child: const Text("Tambah")),

              Consumer<WishlistProvider>(
                builder: (context, counterProvider, child) {
                  return Text("Jumlah item wishlist ${counterProvider.wishlistCount}");
                },
              ),

              ElevatedButton(
                  onPressed: () {
                    context.read<WishlistProvider>().increment();
                  },
                  child: const Text("Tambah Wishlist")
              ),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Kembali")),

              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ThirdState()
                      ),
                    );
                  },
                  child: const Text("Pindah halaman tiga"))
            ],
          ),
        )
    );
  }
}
