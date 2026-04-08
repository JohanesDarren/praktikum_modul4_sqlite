class Saham {
  int? tickerid;
  String ticker;
  int open;
  int high;
  int last;
  double change;

  Saham({
    this.tickerid,
    required this.ticker,
    required this.open,
    required this.high,
    required this.last,
    required this.change,
  });

  Map<String, dynamic> toMap() {
    return {
      'tickerid': tickerid,
      'ticker': ticker,
      'open': open,
      'high': high,
      'last': last,
      'change': change,
    };
  }

  factory Saham.fromMap(Map<String, dynamic> map) {
    return Saham(
      tickerid: map['tickerid'],
      ticker: map['ticker'],
      open: map['open'],
      high: map['high'],
      last: map['last'],
      change: map['change'],
    );
  }
}
