import 'package:flutter/material.dart';
import 'package:ppbl2026/map/maps_example.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Aplikasi Open StreetMap",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: SimpleMapScreen(),
    );



  }
}
