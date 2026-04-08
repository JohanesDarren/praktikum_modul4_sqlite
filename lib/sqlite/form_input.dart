import 'package:flutter/material.dart';
import 'koneksi.dart';
import 'read_data.dart';
import 'saham.dart';

class InputSaham extends StatelessWidget {

  InputSaham({super.key});

  final TextEditingController _tickerController = TextEditingController();
  final TextEditingController _openController = TextEditingController();
  final TextEditingController _highController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _changeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Input Saham"),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _tickerController,
              decoration: InputDecoration(
                labelText: 'Ticker',
              ),
            ),
            TextField(
              controller: _openController,
              decoration: InputDecoration(
                labelText: 'Open',
              ),
            ),
            TextField(
              controller: _highController,
              decoration: InputDecoration(
                labelText: 'High',
              ),
            ),
            TextField(
              controller: _lastController,
              decoration: InputDecoration(
                labelText: 'Last',
              ),
            ),
            TextField(
              controller: _changeController,
              decoration: InputDecoration(
                labelText: 'Change',
              ),
            ),
            TextButton(
                onPressed: (){
                  final saham = Saham(
                    ticker: _tickerController.text,
                    open: int.parse(_openController.text),
                    high: int.parse(_highController.text),
                    last: int.parse(_lastController.text),
                    change: double.parse(_changeController.text),
                  );

                  SahamQueryHandler()
                      .tambahSaham(saham);

                  _tickerController.clear();
                  _openController.clear();
                  _highController.clear();
                  _lastController.clear();
                  _changeController.clear();
                },
                child: Text("Simpan Saham")
            ),
            TextButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListSaham()),
              );
            }, child: Text("Lihat Saham"))
          ],
        ),
      ),
    );
  }
}
