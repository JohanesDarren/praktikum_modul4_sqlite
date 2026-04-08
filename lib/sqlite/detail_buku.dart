import 'package:flutter/material.dart';
import 'saham.dart';

class DetailSaham extends StatefulWidget {
  final Saham saham;

  const DetailSaham({super.key, required this.saham});

  @override
  State<DetailSaham> createState() => _DetailSahamState();

}

class _DetailSahamState extends State<DetailSaham> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Saham"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(widget.saham.ticker),
            Text('Open: ${widget.saham.open}'),
            Text('High: ${widget.saham.high}'),
            Text('Last: ${widget.saham.last}'),
            Text('Change: ${widget.saham.change}%'),
          ],
        )
      )
    );
  }
}
