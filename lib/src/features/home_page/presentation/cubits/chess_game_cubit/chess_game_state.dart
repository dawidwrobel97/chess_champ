part of 'chess_game_cubit.dart';

@immutable
class ChessGameState {
  const ChessGameState({
    this.status = Status.initial,
    this.errorMessage,
    this.chessGameModel,
    this.chessBoardController,
    this.wrongMove,
    this.enabledMoves = true,
  });

  final Status status;
  final String? errorMessage;
  final ChessGameModel? chessGameModel;
  final ChessBoardController? chessBoardController;
  final State? wrongMove;
  final bool enabledMoves;
}
