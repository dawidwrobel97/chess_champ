class ChessGameModel {
  ChessGameModel({
    required this.id,
    required this.rated,
  });
  final String id;
  final bool rated;

  ChessGameModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        rated = json['rated'];
}
