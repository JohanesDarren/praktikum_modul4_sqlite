import 'buku.dart';

// Data Access Object (DAO)
class Penerbit {
  int? penerbitid;
  final String nama_penerbit;
  final String alamat;
  List<Buku> daftarBuku = [];

  Penerbit({this.penerbitid, required this.nama_penerbit, required this.alamat});


  Map<String, Object?> toMap() {
    return {'penerbitid': penerbitid, 'nama_penerbit': nama_penerbit, 'alamat': alamat};
  }

  Map<String, dynamic> toJson() => {
    'penerbitid': penerbitid,
    'nama_penerbit': nama_penerbit,
    'alamat':alamat
  };

  factory Penerbit.fromJson(Map<String, dynamic> json) {
    return Penerbit(
      penerbitid: json['penerbitid'],
      nama_penerbit: json['nama_penerbit'],
      alamat: json['alamat']

    );
  }
}