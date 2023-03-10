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
    // Check whether the move is same as the mistake
    if ((chessBoardController.game.history[move].move.fromAlgebraic ==
            state.wrongMove!.move.fromAlgebraic) &&
        (chessBoardController.game.history[move].move.toAlgebraic ==
            state.wrongMove!.move.toAlgebraic)) {
      chessBoardController.undoMove();
      // Check whether the move is not the best move
    } else if ((chessBoardController.game.history[move].move.fromAlgebraic !=
            state.chessGameModel!.bestMove[0]) ||
        (chessBoardController.game.history[move].move.toAlgebraic !=
            state.chessGameModel!.bestMove[1])) {
      chessBoardController.undoMove();
      print('Wrong Move');
      // Check whether the move is the best possible move
    } else if ((chessBoardController.game.history[move].move.fromAlgebraic ==
            state.chessGameModel!.bestMove[0]) &&
        (chessBoardController.game.history[move].move.toAlgebraic ==
            state.chessGameModel!.bestMove[1])) {
      emit(ChessGameState(
        status: state.status,
        errorMessage: state.errorMessage,
        chessGameModel: state.chessGameModel,
        chessBoardController: state.chessBoardController,
        wrongMove: state.wrongMove,
        enabledMoves: false,
      ));
      print('That is the move!!!!');
    }
  }
}
