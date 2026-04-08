import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> readData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? username = prefs.getString('username');

  return username ?? 'Tidak ada data';
}

class ReadSharedPreference extends StatefulWidget {
  const ReadSharedPreference({super.key});

  @override
  State<ReadSharedPreference> createState() => _ReadSharedPreferenceState();
}

class _ReadSharedPreferenceState extends State<ReadSharedPreference> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contoh Read Shared Preference"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<String>(
              future: readData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text(snapshot.data!);
                }
              }
            ),

          ],
        ),

      ),
    );
  }
}
