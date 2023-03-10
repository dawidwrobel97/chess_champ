import 'package:chess_app/src/features/home_page/data/data_sources/chess_game_data_source.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';

class UserChessGamesRepository {
  UserChessGamesRepository(this._chessGameDataSource);

  final ChessGameDataSource _chessGameDataSource;

  Future<List<ChessGameModel>?> getUserChessGamesFromId(String id) async {
    final json = await _chessGameDataSource.getUserChessGamesFromId(id);

    if (json == null) {
      return null;
    }

    final listOfChessGames =
        json.map((e) => ChessGameModel.fromJson(e)).toList();

    int biggestDifference = 0;
    int moveOnWhichMistakeHappened = 0;
    bool hasBlunder = false;
    bool hasMistake = false;
    for (final chessGame in listOfChessGames) {
      for (var i = 1; i < chessGame.movesAnalysis.length - 1; i++) {
        // If there is a possible mate sequence then no eval is given, so it's impossible to compare, we have to ignore instead
        if (chessGame.movesAnalysis[i].containsKey('mate') ||
            chessGame.movesAnalysis[i - 1].containsKey('mate')) {
          continue;
        }
        // We only want to see our mistakes so we ignore moves made by our opponent
        // All moves by white are even and all moves by black are odd so this filters the moves based on which color the user is
        if (chessGame.userId == chessGame.whitePlayer) {
          if ((i % 2) == 0) {
            continue;
          }
        }
        if (chessGame.userId == chessGame.blackPlayer) {
          if ((i % 2) != 0) {
            continue;
          }
        }
        // If analysis dedects a mistake it always sends more than 1 value and gives best possible move
        // without analsys we don't know what the best move is so we only want moves with analysis
        if (chessGame.movesAnalysis[i].length == 1) {
          continue;
        } else if (chessGame.movesAnalysis[i]['judgment']['name'] ==
            'Blunder') {
          hasBlunder = true;
        } else if (chessGame.movesAnalysis[i]['judgment']['name'] ==
            'Mistake') {
          hasMistake = true;
        }
        // In analysis there are 3 names for mistakes based on how bad they are: blunder, mistake and inaccuracy
        // but sometimes mistakes and innacuracies can technically have bigger difference number while not being as important as blunders
        // that's why if there is a blunder it should always take priority
        if (chessGame.movesAnalysis[i]['judgment']['name'] == 'Mistake' &&
            hasBlunder == true) {
          continue;
        }
        if (chessGame.movesAnalysis[i]['judgment']['name'] == 'Inaccuracy' &&
            (hasBlunder == true || hasMistake == true)) {
          continue;
        }
        int currentDifference = chessGame.movesAnalysis[i]['eval'] -
            chessGame.movesAnalysis[i - 1]['eval'];
        if ((currentDifference).abs() > biggestDifference) {
          if (chessGame.userId == chessGame.whitePlayer &&
              currentDifference < 0) {
            biggestDifference = (currentDifference).abs();
            moveOnWhichMistakeHappened = i - 1;
          } else if (chessGame.userId == chessGame.blackPlayer &&
              currentDifference > 0) {
            biggestDifference = (currentDifference).abs();
            moveOnWhichMistakeHappened = i - 1;
          }
        }
      }
      chessGame.biggestScoreDifference = biggestDifference/100;
      chessGame.moveOnWhichMistakeHappened = moveOnWhichMistakeHappened;
      biggestDifference = 0;
      moveOnWhichMistakeHappened = 0;
      hasBlunder = false;
      hasMistake = false;
    }
    return listOfChessGames;
  }
}
