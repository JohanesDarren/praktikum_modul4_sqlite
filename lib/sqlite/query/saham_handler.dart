import '../query/koneksi.dart';
import 'package:sqflite/sqflite.dart';
import '../dao/saham.dart';

class SahamQueryHandler {
  Future<Database> database() async {
    return openDb();
  }

  Future<void> isiDataSaham() async {
    final db = await database();

    final List<Saham> daftarSaham = [
      Saham(ticker: 'TLKM', open: 3380, high: 3500, last: 3490, change: 2.05),
      Saham(ticker: 'AMMN', open: 6750, high: 6750, last: 6500, change: -3.7),
      Saham(ticker: 'BREN', open: 4500, high: 4610, last: 4580, change: 1.78),
      Saham(ticker: 'CUAN', open: 5200, high: 5525, last: 5400, change: 3.85),
      Saham(ticker: 'BBRI', open: 4900, high: 5150, last: 4950, change: 0.25),
    ];

    await db.transaction((txn) async {
      for (var saham in daftarSaham) {
        await txn.rawInsert(
          'INSERT INTO saham (ticker, open, high, last, change) VALUES (?, ?, ?, ?, ?)',
          [saham.ticker, saham.open, saham.high, saham.last, saham.change],
        );
      }
    });
  }

  Future<List<Saham>> ambilSemuaSaham() async {
    final db = await database();
    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FROM saham');
    return List.generate(maps.length, (i) => Saham.fromJson(maps[i]));
  }

  Future<int> hapusSaham(int id) async {
    final db = await database();
    return await db.delete('saham', where: 'tickerid = ?', whereArgs: [id]);
  }
}
