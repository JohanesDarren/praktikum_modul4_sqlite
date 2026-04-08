// Data Access Object (DAO)
class Saham {
  final int? tickerid;
  final String ticker;
  final int? open;
  final int? high;
  final int? last;
  final double? change;

  Saham({
    this.tickerid,
    required this.ticker,
    this.open,
    this.high,
    this.last,
    this.change,
  });

  Map<String, dynamic> toJson() => {
      'tickerid': tickerid,
      'ticker': ticker,
      'open': open,
      'high': high,
      'last': last,
      'change': change,
  };

  factory Saham.fromJson(Map<String, dynamic> json) {
    return Saham(
      tickerid: json['tickerid'],
      ticker: json['ticker'],
      open: json['open'],
      high: json['high'],
      last: json['last'],
      change: (json['change'] as num?)?.toDouble(),
    );
  }
}