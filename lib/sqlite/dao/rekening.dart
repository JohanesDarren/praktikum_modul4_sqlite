class Rekening {
  int nomor_rekening;
  int userid;
  double saldo;

  Rekening({required this.nomor_rekening, required this.userid, required this.saldo});

  Map<String, Object?> toMap(){
    return {'nomor_rekening': nomor_rekening, 'userid': userid, 'saldo':saldo};
  }

  Map<String, dynamic> toJson() => {
    'nomor_rekening': nomor_rekening,
    'userid': userid,
    'saldo': saldo,
  };
}