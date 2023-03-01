class ChessGameModel {
  ChessGameModel({
    required this.id,
    required this.lastFen
  });
  final String id;
  final String lastFen;

  ChessGameModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        lastFen = json['lastFen'];
}
