import 'package:flutter/material.dart';
import 'package:ppbl2026/state/second_state.dart';
import 'package:provider/provider.dart';
import 'keranjang_provider.dart';
import 'wishlist_provider.dart';

class ContohState extends StatefulWidget {
  const ContohState({super.key});

  @override
  State<ContohState> createState() => _ContohStateState();
}

class _ContohStateState extends State<ContohState> {
  // state
  late int counter = 0;
  late String nama = "DPPB";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contoh State Sederhana"),
      ),
      body: Center(
        child: Column(
          children: [

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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SecondState()
                    ),
                  );
                },
                child: const Text("Pindah halaman dua"))
          ],
        ),
      ),
    );
  }
}