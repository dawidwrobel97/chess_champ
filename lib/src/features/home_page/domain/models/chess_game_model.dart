class ChessGameModel {
  ChessGameModel({
    required this.gameId,
    required this.userId,
    required this.lastFen,
    required this.whitePlayer,
    required this.blackPlayer,
    required this.movesAnalysis,
  });
  final String gameId;
  final String userId;
  final String lastFen;
  final String whitePlayer;
  final String blackPlayer;
  final List<dynamic> movesAnalysis;

  ChessGameModel.fromJson(Map<String, dynamic> json)
      : gameId = json['id'],
        userId = json['userId'],
        lastFen = json['lastFen'],
        whitePlayer = json['players']['white']['user']['name'],
        blackPlayer = json['players']['black']['user']['name'],
        movesAnalysis = json['analysis'];

  Map<String, int> get largestNumberDifference {
    int biggestDifference = 0;
    int moveNumberOfBiggestDifference = 0;
    for (var i = 0; i < movesAnalysis.length - 1; i++) {
      // If there is a possible mate sequence then no eval is given, so it's impossible to compare, we have to ignore instead
      if (movesAnalysis[i].containsKey('mate') ||
          movesAnalysis[i + 1].containsKey('mate')) {
        continue;
      }
      if (userId == whitePlayer) {
        if ((i % 2) != 0) {
          continue;
        }
      }
      if (userId == blackPlayer) {
        if ((i % 2) == 0) {
          continue;
        }
      }
      int currentDifference =
          movesAnalysis[i]['eval'] - movesAnalysis[i + 1]['eval'];
      if ((currentDifference).abs() > biggestDifference) {
        if (userId == whitePlayer && currentDifference > 0) {
          biggestDifference = (currentDifference).abs();
          moveNumberOfBiggestDifference = i;
        } else if (userId == blackPlayer && currentDifference < 0) {
          biggestDifference = (currentDifference).abs();
          moveNumberOfBiggestDifference = i;
        }
      }
    }
    return {
      'biggestDifference': biggestDifference,
      'moveNumberOfBiggestDifference': moveNumberOfBiggestDifference,
    };
  }
}
