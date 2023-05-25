import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'chess_game_model.g.dart';
part 'chess_game_model.freezed.dart';

@freezed
class ChessGameModel with _$ChessGameModel {
  const ChessGameModel._();
  factory ChessGameModel(
    @JsonKey(name: 'id') final String gameId,
    String userId,
    String lastFen,
    dynamic players,
    @JsonKey(name: 'analysis') final List<dynamic> movesAnalysis,
    List<dynamic> movesAsList,
    int createdAt,
    List<dynamic> bestMove,
    double biggestScoreDifference,
    int moveOnWhichMistakeHappened,
    String worstMove,
    bool isPerfectGame,
  ) = _ChessGameModel;

  factory ChessGameModel.fromJson(Map<String, dynamic> json) =>
      _$ChessGameModelFromJson(json);

  String playedGameAt() {
    return DateFormat.yMMMMd()
        .format(DateTime.fromMillisecondsSinceEpoch(createdAt));
  }

  String whitePlayer() {
    return players['white']['user']['name'];
  }

  String blackPlayer() {
    return players['black']['user']['name'];
  }
}