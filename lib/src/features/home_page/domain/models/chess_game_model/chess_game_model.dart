import 'package:json_annotation/json_annotation.dart';

part 'chess_game_model.g.dart';

@JsonSerializable()
class ChessGameModel {
  ChessGameModel({
    required this.id,
    required this.lastFen,
  });
  final String id;
  final String lastFen;

  factory ChessGameModel.fromJson(Map<String, dynamic> json) =>
      _$ChessGameModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChessGameModelToJson(this);
}
