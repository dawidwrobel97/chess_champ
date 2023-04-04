import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chess_game_model.g.dart';

@JsonSerializable()
class ChessGameModel {
  ChessGameModel({
    required this.gameId,
    required this.userId,
    required this.lastFen,
    required this.players,
    required this.movesAnalysis,
    required this.movesAsList,
    required this.createdAt,
    this.bestMove,
    this.biggestScoreDifference,
    this.moveOnWhichMistakeHappened,
    this.worstMove,
  });
  @JsonKey(name: 'id')
  final String gameId;
  final String userId;
  final String lastFen;
  final dynamic players;
  @JsonKey(name: 'analysis')
  final List<dynamic> movesAnalysis;
  final List<dynamic> movesAsList;
  final int createdAt;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<dynamic>? bestMove = [];
  @JsonKey(includeFromJson: false, includeToJson: false)
  double? biggestScoreDifference = 0;
  @JsonKey(includeFromJson: false, includeToJson: false)
  int? moveOnWhichMistakeHappened = 0;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? worstMove = '';

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

  factory ChessGameModel.fromJson(Map<String, dynamic> json) =>
      _$ChessGameModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChessGameModelToJson(this);

  // ChessGameModel.fromJson(Map<String, dynamic> json)
  //     : gameId = json['id'],
  //       userId = json['userId'].toLowerCase(),
  //       lastFen = json['lastFen'],
  //       whitePlayer = json['players']['white']['user']['name'].toLowerCase(),
  //       blackPlayer = json['players']['black']['user']['name'].toLowerCase(),
  //       movesAnalysis = json['analysis'],
  //       movesAsList = json['movesAsList'] as List<dynamic>,
  //       playedAtInt = json['createdAt'];
}
