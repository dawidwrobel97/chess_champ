import 'dart:convert';

import 'package:chess_app/src/data/data_sources/chess_game_data_source.dart';
import 'package:chess_app/src/domain/models/chess_game_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserChessGamesRepository {
  UserChessGamesRepository({required this.chessGameDataSource});

  final ChessGameRemoteRetrofitDataSource chessGameDataSource;

  Future<String> getUserChessGamesFromId(String id) async {
    return await chessGameDataSource.getUserChessGamesFromId(id);
  }

  Future<void> addUserGamesIntoFirebase(String id, String response) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User isn\'t logged in');
    }
    // Lichess API sends it's response in a specific way where each line is it's own json string
    // so we need to seperate them and put them in a List first
    List<String> responseAsListOfStrings =
        const LineSplitter().convert(response);
    final List<Map<String, dynamic>> responseAsListMap = [];
    for (var i = 0; i < responseAsListOfStrings.length; i++) {
      responseAsListMap.add(jsonDecode(responseAsListOfStrings[i]));
      responseAsListMap[i].addAll({'userId': id});
      // Analysis doesn't have the starting position analysis in it so I have to add one myself
      responseAsListMap[i]['analysis'].insert(0, {'eval': 26});
      List<dynamic> movesAsList = responseAsListMap[i]['moves'].split(' ');
      responseAsListMap[i].addAll({'movesAsList': movesAsList});
      responseAsListMap[i].addAll({'bestMove': []});
      responseAsListMap[i].addAll({'biggestScoreDifference': 0});
      responseAsListMap[i].addAll({'moveOnWhichMistakeHappened': 0});
      responseAsListMap[i].addAll({'worstMove': ''});
      responseAsListMap[i].addAll({'isPerfectGame': false});
    }
    final listOfChessGames =
        responseAsListMap.map((e) => ChessGameModel.fromJson(e)).toList();

    // Now that we have a proper list of chess games we search each game for biggest mistakes and best moves
    double biggestDifference = 0;
    int moveOnWhichMistakeHappened = 0;
    List<dynamic> bestMove = [];
    String worstMove = '';
    bool hasBlunder = false;
    bool hasMistake = false;
    bool isPerfectGame = false;
    for (final chessGame in listOfChessGames) {
      // First we go through every move in the game
      for (var i = 1; i < chessGame.movesAnalysis.length - 1; i++) {
        // If there is a possible mate sequence then no eval is given, so it's impossible to compare, so we have to ignore instead
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
        // Analysis is only send when a mistake is found
        // when analysis detects a mistake it always sends more than 1 value and gives best possible move
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
        // but blunders should always take priority
        if (chessGame.movesAnalysis[i]['judgment']['name'] == 'Mistake' &&
            hasBlunder == true) {
          continue;
        }
        if (chessGame.movesAnalysis[i]['judgment']['name'] == 'Inaccuracy' &&
            (hasBlunder == true || hasMistake == true)) {
          continue;
        }
        // Once we finally get here we check if our current move is the biggest difference
        int currentDifference = chessGame.movesAnalysis[i]['eval'] -
            chessGame.movesAnalysis[i - 1]['eval'];
        if ((currentDifference).abs() > biggestDifference) {
          if (chessGame.userId.toLowerCase() ==
                  chessGame.whitePlayer().toLowerCase() &&
              currentDifference < 0) {
            biggestDifference = (currentDifference).abs().toDouble();
            moveOnWhichMistakeHappened = i - 1;
          } else if (chessGame.userId.toLowerCase() ==
                  chessGame.blackPlayer().toLowerCase() &&
              currentDifference > 0) {
            biggestDifference = (currentDifference).abs().toDouble();
            moveOnWhichMistakeHappened = i - 1;
          }
        }
      }
      if (moveOnWhichMistakeHappened != 0) {
        // Once we check all moves in a game we save the stats
        biggestDifference /= 100;
        worstMove = chessGame.movesAsList[moveOnWhichMistakeHappened];
        // We take the best move analysis and split the string into 2 so it's easier to use in the future
        for (int i = 0;
            i <
                chessGame.movesAnalysis[moveOnWhichMistakeHappened + 1]['best']
                    .length;
            i += 2) {
          bestMove.add(chessGame.movesAnalysis[moveOnWhichMistakeHappened + 1]
                  ['best']
              .substring(i, i + 2));
        }
      } else {
        isPerfectGame = true;
      }
      // Now we finally add the correct game into the database
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
        'bestMove': bestMove,
        'biggestScoreDifference': biggestDifference,
        'moveOnWhichMistakeHappened': moveOnWhichMistakeHappened,
        'worstMove': worstMove,
        'isPerfectGame': isPerfectGame,
      });
      biggestDifference = 0;
      moveOnWhichMistakeHappened = 0;
      bestMove = [];
      hasBlunder = false;
      hasMistake = false;
      isPerfectGame = false;
    }
  }

  Future<void> deleteAllCurrentGames() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    var collection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('chess_games');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
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

  Future<void> addGameToFavourites(ChessGameModel chessGame) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favourites')
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
      'isPerfectGame': chessGame.isPerfectGame,
    });
  }
}
