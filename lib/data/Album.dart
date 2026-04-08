class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  // konversi data ke json
  Map<String, dynamic> toJson() => {
    'userId': userId,
    'id': id,
    'title': title,
  };

  // konversi json ke object
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId  : json['userId'],
      id      : json['id'],
      title   : json['title'],
    );
  }
}