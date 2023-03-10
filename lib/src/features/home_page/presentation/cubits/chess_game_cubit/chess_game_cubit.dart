import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chess/chess.dart';
import 'package:chess_app/src/core/enums/enums.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:meta/meta.dart';

part 'chess_game_state.dart';

class ChessGameCubit extends Cubit<ChessGameState> {
  ChessGameCubit() : super(const ChessGameState());

  ChessBoardController chessBoardController = ChessBoardController();

  Future<void> start(ChessGameModel chessGameModel) async {
    emit(const ChessGameState(status: Status.loading));
    for (var i = 0; i < chessGameModel.moveOnWhichMistakeHappened + 1; i++) {
      chessBoardController
          .makeMoveWithNormalNotation(chessGameModel.movesAsList[i]);
    }
    final State wrongMove = chessBoardController
        .game.history[chessGameModel.moveOnWhichMistakeHappened];
    inspect(wrongMove);
    chessBoardController.undoMove();
    try {
      emit(ChessGameState(
        wrongMove: wrongMove,
        chessBoardController: chessBoardController,
        chessGameModel: chessGameModel,
        status: Status.success,
      ));
    } catch (error) {
      emit(ChessGameState(
        errorMessage: error.toString(),
        status: Status.error,
      ));
    }
  }

  Future<void> madeMove(int move) async {
    if ((chessBoardController.game.history[move].move.from ==
            state.wrongMove!.move.from) &&
        (chessBoardController.game.history[move].move.to ==
            state.wrongMove!.move.to)) {
      print('To ten sam zły ruch pajacu');
      chessBoardController.undoMove();
    }
  }
}
