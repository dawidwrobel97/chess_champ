part of 'chess_game_cubit.dart';

@freezed
class ChessGameState with _$ChessGameState {
  const factory ChessGameState({
    @Default(Status.initial) Status status,
    @Default(true) bool enabledMoves,
    @Default(false) bool madeWrongMove,
    @Default(false)bool madeTheSameMistake,
    @Default(false) bool madeTheBestMove,
    @Default(false) bool pressedButtonForSolution,
    String? errorMessage,
    ChessGameModel? chessGameModel,
    ChessBoardController? chessBoardController,
    State? wrongMove,
  }) = _ChessGameState;
}
