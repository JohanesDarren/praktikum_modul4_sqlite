// Data Access Object (DAO)
class Buku {
  int? bukuid;
  final String nama_buku;
  final int isbn;
  int? penerbitid;

  Buku({this.bukuid, required this.nama_buku, required this.isbn, this.penerbitid});

  Map<String, Object?> toMap(){
    return {'bukuid': bukuid, 'nama_buku': nama_buku, 'isbn': isbn, 'penerbitid': penerbitid};
  }

  Map<String, dynamic> toJson() => {
      'bukuid': bukuid,
      'nama_buku': nama_buku,
      'isbn': isbn,
  };

  factory Buku.fromJson(Map<String, dynamic> json) {
    return Buku(
      bukuid: json['bukuid'],
      nama_buku: json['nama_buku'],
      isbn: json['isbn'],
      penerbitid: json['penerbitid']
    );
  }
}