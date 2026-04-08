import 'package:sqflite/sqflite.dart';
import 'saham.dart';

// $conn = mysqli_connect('localhost', 'root', '', 'perpustakaan')

Future<Database> openDb() async{
  final database = await openDatabase(
    'database_perpustakaan',
    version:  4,
    onCreate: (db, version) async{
      await db.execute('''
          CREATE TABLE saham (
            tickerid INTEGER PRIMARY KEY AUTOINCREMENT,
            ticker TEXT NOT NULL,
            open INTEGER,
            high INTEGER,
            last INTEGER,
            change REAL
          )
          ''');

      await _seedSaham(db);
    },
      onUpgrade: (db, oldVersion, newVersion) async{
        if (oldVersion < 2) {
          await db.execute('''
          CREATE TABLE penerbit (
            penerbitid INTEGER PRIMARY KEY AUTOINCREMENT,
            nama_penerbit TEXT NOT NULL,
            alamat TEXT NOT NULL
          )
          ''');
        }

        if (oldVersion < 3) {
          await db.execute('''
          CREATE TABLE pengarang (
            pengarangid INTEGER PRIMARY KEY AUTOINCREMENT,
            nama_pengarang TEXT NOT NULL
          )
          ''');
        }

        if (oldVersion < 4) {
          await db.execute('DROP TABLE IF EXISTS buku');
          await db.execute('''
          CREATE TABLE saham (
            tickerid INTEGER PRIMARY KEY AUTOINCREMENT,
            ticker TEXT NOT NULL,
            open INTEGER,
            high INTEGER,
            last INTEGER,
            change REAL
          )
          ''');
          await _seedSaham(db);
        }

      },
      onDowngrade: (db, oldVersion, newVersion) async{
        await db.execute('DROP TABLE IF EXISTS penerbit');
        await db.execute('DROP TABLE IF EXISTS pengarang');
        await db.execute('DROP TABLE IF EXISTS buku');
        await db.execute('DROP TABLE IF EXISTS saham');
        await openDb();
      },
  );
  return database;
}

Future<void> _seedSaham(Database db) async {
  final existing = Sqflite.firstIntValue(
    await db.rawQuery('SELECT COUNT(*) FROM saham'),
  );

  if (existing != null && existing > 0) {
    return;
  }

  const seedData = [
    {
      'ticker': 'TLKM',
      'open': 3380,
      'high': 3500,
      'last': 3490,
      'change': 2.05,
    },
    {
      'ticker': 'AMMN',
      'open': 6750,
      'high': 6750,
      'last': 6500,
      'change': -3.7,
    },
    {
      'ticker': 'BREN',
      'open': 4500,
      'high': 4610,
      'last': 4580,
      'change': 1.78,
    },
    {
      'ticker': 'CUAN',
      'open': 5200,
      'high': 5525,
      'last': 5400,
      'change': 3.85,
    },
  ];

  for (final saham in seedData) {
    await db.insert('saham', saham);
  }
}

class PenerbitQueryHandler{
  Future<Database> database() async {
    return openDb();
  }
}
// mysqli_query($conn, "SELECT * FROM buku")

class SahamQueryHandler{
  Future<Database> database() async {
    return openDb();
  }
  Future<int> tambahSaham(Saham saham) async{
    final db = await database();
    final id = await db.rawInsert(
      'INSERT INTO saham (ticker, open, high, last, change) VALUES (?, ?, ?, ?, ?)',
      [saham.ticker, saham.open, saham.high, saham.last, saham.change]
    );
    return id;
  }

  Future<List<Saham>> ambilSemuaSaham() async{
    final db = await database();
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM saham ORDER BY tickerid ASC');

    return List.generate(maps.length, (i){
      return Saham.fromJson(maps[i]);
    });
  }

  Future<int> updateSaham(Saham saham) async {
    final db = await database();

    final result = await db.rawUpdate(
      'UPDATE saham SET ticker = ?, open = ?, high = ?, last = ?, change = ? WHERE tickerid = ?',
      [saham.ticker, saham.open, saham.high, saham.last, saham.change, saham.tickerid],
    );

    return result;
  }

  Future<int> hapusSaham(int tickerid) async {
    final db = await database();
    final result = await db.delete('saham', where: 'tickerid = ?', whereArgs: [tickerid]);

    return result;
  }

}


