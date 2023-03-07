class ChessGameModel {
  ChessGameModel(
      {required this.gameId,
      required this.userId,
      required this.lastFen,
      required this.whitePlayer,
      required this.blackPlayer,
      required this.movesAnalysis,
      required this.movesAsList,
      required this.biggestMistakeInGame});
  final String gameId;
  final String userId;
  final String lastFen;
  final String whitePlayer;
  final String blackPlayer;
  final List<dynamic> movesAnalysis;
  final List<String> movesAsList;
  Map<String, dynamic> biggestMistakeInGame = {};

  ChessGameModel.fromJson(Map<String, dynamic> json)
      : gameId = json['id'],
        userId = json['userId'],
        lastFen = json['lastFen'],
        whitePlayer = json['players']['white']['user']['name'],
        blackPlayer = json['players']['black']['user']['name'],
        movesAnalysis = json['analysis'],
        movesAsList = json['movesAsList'];
}
