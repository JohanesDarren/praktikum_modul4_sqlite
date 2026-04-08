import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'keranjang_provider.dart';
import 'wishlist_provider.dart';

class ThirdState extends StatefulWidget {
  ThirdState({super.key});

  @override
  State<ThirdState> createState() => _ThirdStateState();
}

class _ThirdStateState extends State<ThirdState> {

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

            ],
          ),
        )
    );
  }
}
