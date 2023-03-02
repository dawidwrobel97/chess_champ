// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chess_game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChessGameModel _$ChessGameModelFromJson(Map<String, dynamic> json) =>
    ChessGameModel(
      id: json['id'] as String,
      lastFen: json['lastFen'] as String,
    );

Map<String, dynamic> _$ChessGameModelToJson(ChessGameModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lastFen': instance.lastFen,
    };
