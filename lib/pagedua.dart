import 'package:flutter/material.dart';

class Pagedua extends StatelessWidget {
  const Pagedua({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Halaman Dua",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Halaman Dua"),

        ),
        body: Text("Page Dua"),
      ),
    );
  }
}
