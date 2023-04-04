// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chess_game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChessGameModel _$ChessGameModelFromJson(Map<String, dynamic> json) =>
    ChessGameModel(
      gameId: json['id'] as String,
      userId: json['userId'] as String,
      lastFen: json['lastFen'] as String,
      players: json['players'],
      movesAnalysis: json['analysis'] as List<dynamic>,
      movesAsList: json['movesAsList'] as List<dynamic>,
      createdAt: json['createdAt'] as int,
    );

Map<String, dynamic> _$ChessGameModelToJson(ChessGameModel instance) =>
    <String, dynamic>{
      'id': instance.gameId,
      'userId': instance.userId,
      'lastFen': instance.lastFen,
      'players': instance.players,
      'analysis': instance.movesAnalysis,
      'movesAsList': instance.movesAsList,
      'createdAt': instance.createdAt,
    };
