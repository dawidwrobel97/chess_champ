import 'package:bloc/bloc.dart';
import 'package:chess_app/src/core/enums/enums.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:meta/meta.dart';

part 'chess_game_state.dart';

class ChessGameCubit extends Cubit<ChessGameState> {
  ChessGameCubit() : super(const ChessGameState());

  ChessBoardController chessBoardController = ChessBoardController();

  Future<void> start(ChessGameModel chessGameModel) async {
    for (var i = 0;
        i < chessGameModel.biggestMistakeInGame['moveOnWhichMistakeHappened'];
        i++) {
      chessBoardController
          .makeMoveWithNormalNotation(chessGameModel.movesAsList[i]);
    }
    emit(const ChessGameState(status: Status.loading));
    try {
      emit(ChessGameState(
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
}
