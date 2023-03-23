part of 'chess_game_cubit.dart';

@freezed
class ChessGameState with _$ChessGameState {
  const factory ChessGameState({
    required Status status,
    required bool enabledMoves,
    required bool madeWrongMove,
    required bool madeTheSameMistake,
    required bool madeTheBestMove,
    required bool pressedButtonForSolution,
    String? errorMessage,
    ChessGameModel? chessGameModel,
    ChessBoardController? chessBoardController,
    State? wrongMove,
  }) = _ChessGameState;
}
