part of 'chess_game_cubit.dart';

@freezed
class ChessGameState with _$ChessGameState {
  const factory ChessGameState({
    required Status status,
    String? errorMessage,
    ChessGameModel? chessGameModel,
    ChessBoardController? chessBoardController,
    State? wrongMove,
    required bool enabledMoves,
    required bool madeWrongMove,
    required bool madeTheSameMistake,
    required bool madeTheBestMove,
  }) = _ChessGameState;
}
