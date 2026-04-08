import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'saham.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'saham_database.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE saham("
          "tickerid INTEGER PRIMARY KEY AUTOINCREMENT, "
          "ticker TEXT NOT NULL, "
          "open INTEGER, "
          "high INTEGER, "
          "last INTEGER, "
          "change REAL)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertSaham(Saham saham) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert('saham', saham.toMap());
    return result;
  }

  Future<void> insertDummyData() async {
    final List<Saham> dummyData = [
      Saham(ticker: 'TLKM', open: 3380, high: 3500, last: 3490, change: 2.05),
      Saham(ticker: 'AMMN', open: 6750, high: 6750, last: 6500, change: -3.7),
      Saham(ticker: 'BREN', open: 4500, high: 4610, last: 4580, change: 1.78),
      Saham(ticker: 'CUAN', open: 5200, high: 5525, last: 5400, change: 3.85),
    ];

    for (var saham in dummyData) {
      await insertSaham(saham);
    }
  }

  Future<List<Saham>> retrieveSaham() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('saham');
    return queryResult.map((e) => Saham.fromMap(e)).toList();
  }
}
