import 'package:flutter/material.dart';
import 'package:ppbl2026/shared_preference/read_state_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString('username', 'PTI'); // $_SESSION['username'] = 'PPBL'
  await prefs.setInt('age', 32); // $_SESSION['age'] = 32
  await prefs.setDouble('height', 5.5);
  await prefs.setBool('isLoggedIn', true);
  await prefs.setStringList('hobbies', ['Reading', 'Gaming', 'Coding']);
  await prefs.setString('token', 'epr1ueuqdfjaoifo9a');
  await prefs.setString('token_expiry', '2026-04-01 00:00:00');
}

Future<void> removeHeight() async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('height');
}

class SharedPreference extends StatefulWidget {
  const SharedPreference({super.key});

  @override
  State<SharedPreference> createState() => _SharedPreferenceState();
}

class _SharedPreferenceState extends State<SharedPreference> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contoh Shared Preference"),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async{
                  saveData();
                },
                child: Text("Simpan Data"),
              ),
              TextButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReadSharedPreference()),
                  );
                },
                child: Text("Pindah Halaman"),
              ),
            ]

        )


      )
    );
  }
}
