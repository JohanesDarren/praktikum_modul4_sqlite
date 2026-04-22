import '../query/koneksi.dart';
import 'package:sqflite/sqflite.dart';
import '../dao/rekening.dart';

class RekeningQueryHandler{
  Future<Database> database() async {
    return openDb();
  }

  Future<void> isiDaftarRekening(List<Rekening> daftarRekening)async {
    final db = await database();
    await db.transaction((txn) async{
      for(var rekening in daftarRekening){
        await txn.rawInsert('INSERT INTO rekening (userid, saldo) VALUES (?, ?)',
            [rekening.userid, rekening.saldo]);
      }
    });

  }

  Future<void> isiRekening(int userId, double amount) async{
    final db = await database();
    await db.rawInsert(
        'INSERT INTO rekening (userid, saldo) VALUES (?, ?)',
        [userId, amount]
    );

  }

  Future<double> bacaSaldo(int nomorRekening) async{
    final db = await database();
    List<Map<String, Object?>> result = await db.rawQuery("SELECT saldo FROM rekening where nomor_rekening = ?", [nomorRekening]);
    return result.first['saldo'] as double;
  }

  Future<void> safeTransfer(int senderId, int receiverId, double amount) async {
    final db = await database();

    await db.transaction((txn) async{
      await txn.rawUpdate(
        'UPDATE rekening SET saldo = saldo - ? WHERE nomor_rekening = ?',
        [amount, senderId],
      );

      throw Exception("Simulated Crash! Koneksi bermasalah");

      // 2. Add money to Author (This code will NEVER run)
      await txn.rawUpdate(
        'UPDATE rekening SET saldo = saldo + ? WHERE nomor_rekening = ?',
        [amount, receiverId],
      );
    });
  }

  Future<void> dangerousTransfer(int senderId, int receiverId, double amount) async {
    final db = await database();
    // 1. Deduct money from Publisher
    await db.rawUpdate(
      'UPDATE rekening SET saldo = saldo - ? WHERE nomor_rekening = ?',
      [amount, senderId],
    );

    throw Exception("Simulated Crash! Koneksi bermasalah");

    // 2. Add money to Author (This code will NEVER run)
    await db.rawUpdate(
      'UPDATE rekening SET saldo = saldo + ? WHERE nomor_rekening = ?',
      [amount, receiverId],
    );
  }
}