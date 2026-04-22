PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE android_metadata (locale TEXT);
INSERT INTO android_metadata VALUES('en_US');
CREATE TABLE buku (
            bukuid INTEGER PRIMARY KEY AUTOINCREMENT,
            nama_buku TEXT NOT NULL,
            isbn INTEGER NOT NULL
          , penerbitid INTEGER REFERENCES penerbit(penerbitid) DEFAULT NULL);
INSERT INTO buku VALUES(0,'Harry Potter',123456,NULL);
INSERT INTO buku VALUES(1,'Lord of The Ring',4455,NULL);
INSERT INTO buku VALUES(2,'Milea',5555,NULL);
INSERT INTO buku VALUES(3,'Sherlock Holmes',9876,NULL);
INSERT INTO buku VALUES(4,'Lupin',121222,NULL);
INSERT INTO buku VALUES(5,'Dilan',20987,NULL);
INSERT INTO buku VALUES(6,'MLTR',321312,NULL);
INSERT INTO buku VALUES(7,'Bon Jovi',4343,NULL);
INSERT INTO buku VALUES(8,'Noriyuki Makihara',111,NULL);
CREATE TABLE penerbit (
            penerbitid INTEGER PRIMARY KEY AUTOINCREMENT,
            nama_penerbit TEXT NOT NULL,
            alamat TEXT NOT NULL
          );
CREATE TABLE pengarang (
            pengarangid INTEGER PRIMARY KEY AUTOINCREMENT,
            nama_pengarang TEXT NOT NULL
          );
CREATE TABLE kategori (
              kategoriid INTEGER PRIMARY KEY AUTOINCREMENT,
              nama_kategori TEXT NOT NULL
            );
CREATE TABLE rekening (
              nomor_rekening INTEGER PRIMARY KEY AUTOINCREMENT,
              userid INTEGER NOT NULL,
              saldo REAL NOT NULL
            );
INSERT INTO rekening VALUES(1,1,0.0);
INSERT INTO rekening VALUES(2,1,2400000.0);
INSERT INTO rekening VALUES(3,1,-800000.0);
INSERT INTO rekening VALUES(4,1,1000000.0);
INSERT INTO rekening VALUES(5,1,2000000.0);
INSERT INTO sqlite_sequence VALUES('buku',8);
INSERT INTO sqlite_sequence VALUES('rekening',5);
COMMIT;