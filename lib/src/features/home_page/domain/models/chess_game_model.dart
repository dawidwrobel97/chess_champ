class ChessGameModel {
  ChessGameModel({
    required this.id,
    required this.userID,
    required this.lastFen,
    required this.whitePlayer,
    required this.blackPlayer,
  });
  final String id;
  final String userID;
  final String lastFen;
  final String whitePlayer;
  final String blackPlayer;

  ChessGameModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userID  = json['userID'],
        lastFen = json['lastFen'],
        whitePlayer = json['players']['white']['user']['name'],
        blackPlayer = json['players']['black']['user']['name'];
}
