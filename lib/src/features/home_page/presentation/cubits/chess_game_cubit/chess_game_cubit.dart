import 'package:bloc/bloc.dart';
import 'package:chess/chess.dart';
import 'package:chess_app/src/core/enums/enums.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chess_game_state.dart';
part 'chess_game_cubit.freezed.dart';

class ChessGameCubit extends Cubit<ChessGameState> {
  ChessGameCubit()
      : super(const ChessGameState(
          status: Status.initial,
          enabledMoves: true,
        ));

  ChessBoardController chessBoardController = ChessBoardController();

  Future<void> start(ChessGameModel chessGameModel) async {
    emit(state.copyWith(status: Status.loading));
    for (var i = 0; i < chessGameModel.moveOnWhichMistakeHappened + 1; i++) {
      chessBoardController
          .makeMoveWithNormalNotation(chessGameModel.movesAsList[i]);
    }
    final State wrongMove = chessBoardController
        .game.history[chessGameModel.moveOnWhichMistakeHappened];
    if (wrongMove.move.piece.name == 'p') {
      chessBoardController.game.half_moves = 1;
      chessBoardController.undoMove();
    }
    chessBoardController.undoMove();

    try {
      emit(state.copyWith(
        chessBoardController: chessBoardController,
        wrongMove: wrongMove,
        chessGameModel: chessGameModel,
        status: Status.success,
      ));
    } catch (error) {
      emit(state.copyWith(
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
      // Every time I want to undoMove i have to make the half.moves value equal to 1 else it might bug out and not work correctly
      // I don't actually understand why, but it has to be a deeper issue within flutter_chess_board.dart or chess.dart widgets
      // They are not mine so I just put this fix here, with it everything works fine
      chessBoardController.game.half_moves = 1;
      chessBoardController.undoMove();
    }
    // Check whether the move is not the best move
    else if ((chessBoardController.game.history[move].move.fromAlgebraic !=
            state.chessGameModel!.bestMove[0]) ||
        (chessBoardController.game.history[move].move.toAlgebraic !=
            state.chessGameModel!.bestMove[1])) {
      chessBoardController.game.half_moves = 1;
      chessBoardController.undoMove();
    }
    // Check whether the move is the best possible move
    else if ((chessBoardController.game.history[move].move.fromAlgebraic ==
            state.chessGameModel!.bestMove[0]) &&
        (chessBoardController.game.history[move].move.toAlgebraic ==
            state.chessGameModel!.bestMove[1])) {
      chessBoardController.game.half_moves = 1;
      emit(
        state.copyWith(enabledMoves: false),
      );
    }
  }
}
