import 'package:flutter/material.dart';
import '../dao/penerbit.dart';
import 'koneksi.dart';
import 'package:sqflite/sqflite.dart';

class PenerbitQueryHandler{
  Future<Database> database() async {
    return openDb();
  }

  Future<void> insertBatch(List<Penerbit> daftarPenerbit) async{
    final db = await database();
    await db.transaction((txn) async {
      for (var penerbit in daftarPenerbit) {
        penerbit.penerbitid = await txn.insert('penerbit', penerbit.toMap());
        for(var buku in penerbit.daftarBuku){
          buku.penerbitid = penerbit.penerbitid;
          buku.bukuid = await txn.insert('buku', buku.toMap());
        }
      }
    });
  }

  Future<void> dangerousTransfer(Database db, int senderId, int receiverId, double amount) async {
    // 1. Deduct money from Publisher
    await db.rawUpdate(
      'UPDATE accounts SET balance = balance - ? WHERE id = ?',
      [amount, senderId],
    );

    // 🛑 SIMULATED ERROR: Imagine the app crashes here or a network error occurs!
    throw Exception("Simulated Crash!");

    // 2. Add money to Author (This code will NEVER run)
    await db.rawUpdate(
      'UPDATE accounts SET balance = balance + ? WHERE id = ?',
      [amount, receiverId],
    );
  }
}
