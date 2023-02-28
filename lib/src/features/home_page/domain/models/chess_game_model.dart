class ChessGameModel {
  ChessGameModel({
    required this.id,
    required this.rated,
    required this.lastFen
  });
  final String id;
  final bool rated;
  final String lastFen;

  ChessGameModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        rated = json['rated'],
        lastFen = json['lastFen'];
}
