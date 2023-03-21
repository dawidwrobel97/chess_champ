import 'package:intl/intl.dart';

class ChessGameModel {
  ChessGameModel({
    required this.gameId,
    required this.userId,
    required this.lastFen,
    required this.whitePlayer,
    required this.blackPlayer,
    required this.movesAnalysis,
    required this.movesAsList,
    required this.playedAtInt,
    required this.bestMove,
    required this.biggestScoreDifference,
    required this.moveOnWhichMistakeHappened,
    required this.worstMove,
  });
  final String gameId;
  final String userId;
  final String lastFen;
  final String whitePlayer;
  final String blackPlayer;
  final List<dynamic> movesAnalysis;
  final List<dynamic> movesAsList;
  final int playedAtInt;
  List<dynamic> bestMove = [];
  double biggestScoreDifference = 0;
  int moveOnWhichMistakeHappened = 0;
  String worstMove = '';

  String playedGameAt() {
    return DateFormat.yMMMMd()
        .format(DateTime.fromMillisecondsSinceEpoch(playedAtInt));
  }

  ChessGameModel.fromJson(Map<String, dynamic> json)
      : gameId = json['id'],
        userId = json['userId'].toLowerCase(),
        lastFen = json['lastFen'],
        whitePlayer = json['players']['white']['user']['name'].toLowerCase(),
        blackPlayer = json['players']['black']['user']['name'].toLowerCase(),
        movesAnalysis = json['analysis'],
        movesAsList = json['movesAsList'] as List<dynamic>,
        playedAtInt = json['createdAt'];
}
