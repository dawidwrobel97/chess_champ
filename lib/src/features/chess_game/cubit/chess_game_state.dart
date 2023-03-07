part of 'chess_game_cubit.dart';

@immutable
class ChessGameState {
  const ChessGameState({
    this.status = Status.initial,
    this.errorMessage,
    this.chessGameModel,
  });

  final Status status;
  final String? errorMessage;
  final ChessGameModel? chessGameModel;
}
