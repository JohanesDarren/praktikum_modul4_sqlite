// Data Access Object (DAO)
class Buku {
  final int? bukuid;
  final String nama_buku;
  final int isbn;

  Buku({this.bukuid, required this.nama_buku, required this.isbn});

  Map<String, dynamic> toJson() => {
      'bukuid': bukuid,
      'nama_buku': nama_buku,
      'isbn': isbn,
  };

  factory Buku.fromJson(Map<String, dynamic> json) {
    return Buku(
      bukuid: json['bukuid'],
      nama_buku: json['nama_buku'],
      isbn: json['isbn'],);
  }
}