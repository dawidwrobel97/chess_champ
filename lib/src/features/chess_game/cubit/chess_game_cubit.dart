import 'package:bloc/bloc.dart';
import 'package:chess_app/src/core/enums/enums.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:meta/meta.dart';

part 'chess_game_state.dart';

class ChessGameCubit extends Cubit<ChessGameState> {
  ChessGameCubit() : super(const ChessGameState());

  Future<void> start(ChessGameModel chessGameModel) async {
    emit(const ChessGameState(status: Status.loading));
    try {
      emit(ChessGameState(
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
