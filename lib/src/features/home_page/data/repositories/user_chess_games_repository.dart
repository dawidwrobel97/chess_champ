import 'package:chess_app/src/features/home_page/data/data_sources/chess_game_data_source.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserChessGamesRepository {
  UserChessGamesRepository(this._chessGameDataSource);

  final ChessGameDataSource _chessGameDataSource;

  Future<void> addUserGamesIntoFirebase(String id) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User isn\'t logged in');
    }
    final json = await _chessGameDataSource.getUserChessGamesFromId(id);

    if (json == null) {
      return;
    }

    final listOfChessGames =
        json.map((e) => ChessGameModel.fromJson(e)).toList();

    int biggestDifference = 0;
    int moveOnWhichMistakeHappened = 0;
    List<dynamic> bestMove = [];
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
        if (chessGame.userId.toLowerCase() ==
            chessGame.whitePlayer().toLowerCase()) {
          if ((i % 2) == 0) {
            continue;
          }
        }
        if (chessGame.userId.toLowerCase() ==
            chessGame.blackPlayer().toLowerCase()) {
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
          if (chessGame.userId.toLowerCase() ==
                  chessGame.whitePlayer().toLowerCase() &&
              currentDifference < 0) {
            biggestDifference = (currentDifference).abs();
            moveOnWhichMistakeHappened = i - 1;
          } else if (chessGame.userId.toLowerCase() ==
                  chessGame.blackPlayer().toLowerCase() &&
              currentDifference > 0) {
            biggestDifference = (currentDifference).abs();
            moveOnWhichMistakeHappened = i - 1;
          }
        }
      }
      chessGame.biggestScoreDifference = biggestDifference / 100;
      chessGame.moveOnWhichMistakeHappened = moveOnWhichMistakeHappened;
      chessGame.worstMove = chessGame.movesAsList[moveOnWhichMistakeHappened];
      // We take the best move analysis and split the string into 2 so it's easier to use in the future
      for (int i = 0;
          i <
              chessGame
                  .movesAnalysis[chessGame.moveOnWhichMistakeHappened! + 1]
                      ['best']
                  .length;
          i += 2) {
        bestMove.add(chessGame
            .movesAnalysis[chessGame.moveOnWhichMistakeHappened! + 1]['best']
            .substring(i, i + 2));
      }
      chessGame.bestMove = bestMove;
      // Add the now correct game into the database
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('chess_games')
          .add({
        'id': chessGame.gameId,
        'userId': chessGame.userId,
        'lastFen': chessGame.lastFen,
        'players': chessGame.players,
        'analysis': chessGame.movesAnalysis,
        'movesAsList': chessGame.movesAsList,
        'createdAt': chessGame.createdAt,
        'bestMove': chessGame.bestMove,
        'biggestScoreDifference': chessGame.biggestScoreDifference,
        'moveOnWhichMistakeHappened': chessGame.moveOnWhichMistakeHappened,
        'worstMove': chessGame.worstMove,
      });
      biggestDifference = 0;
      moveOnWhichMistakeHappened = 0;
      bestMove = [];
      hasBlunder = false;
      hasMistake = false;
    }
  }

  Future<void> deleteAllCurrentGames() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User isn\'t logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('chess_games')
        .get()
        .then(
      (querySnapshots) {
        for (var docSnapshot in querySnapshots.docs) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('chess_games')
              .doc(docSnapshot.id)
              .delete();
        }
      },
    );
  }

  Stream<List<ChessGameModel>> getUserChessGamesStream() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User isn\'t logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('chess_games')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
      (data) {
        return data.docs.map(
          (doc) {
            return ChessGameModel.fromJson(doc.data());
          },
        ).toList();
      },
    );
  }
}
