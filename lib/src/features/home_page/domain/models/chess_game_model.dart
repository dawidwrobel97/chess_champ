class ChessGameModel {
  ChessGameModel({
    required this.id,
    required this.userID,
    required this.lastFen,
    required this.whitePlayer,
    required this.blackPlayer,
    required this.movesAnalysis,
  });
  final String id;
  final String userID;
  final String lastFen;
  final String whitePlayer;
  final String blackPlayer;
  final List movesAnalysis;

  ChessGameModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userID = json['userID'],
        lastFen = json['lastFen'],
        whitePlayer = json['players']['white']['user']['name'],
        blackPlayer = json['players']['black']['user']['name'],
        movesAnalysis = json['analysis'];

  int get largestNumberDifference {
    int currentBiggestDifference = 0;
    for (var i = 0; i < movesAnalysis.length; i++) {
      int currentDifference =
          movesAnalysis[i]['eval'] - movesAnalysis[i + 1]['eval'];
      if (currentDifference.abs() > currentBiggestDifference) {
        currentBiggestDifference == currentDifference.abs();
      }
    }
    return currentBiggestDifference;
  }
}
