// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chess_game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChessGameModel _$$_ChessGameModelFromJson(Map<String, dynamic> json) =>
    _$_ChessGameModel(
      json['id'] as String,
      json['userId'] as String,
      json['lastFen'] as String,
      json['players'],
      json['analysis'] as List<dynamic>,
      json['movesAsList'] as List<dynamic>,
      json['createdAt'] as int,
      json['bestMove'] as List<dynamic>?,
      (json['biggestScoreDifference'] as num?)?.toDouble(),
      json['moveOnWhichMistakeHappened'] as int?,
      json['worstMove'] as String?,
    );

Map<String, dynamic> _$$_ChessGameModelToJson(_$_ChessGameModel instance) =>
    <String, dynamic>{
      'id': instance.gameId,
      'userId': instance.userId,
      'lastFen': instance.lastFen,
      'players': instance.players,
      'analysis': instance.movesAnalysis,
      'movesAsList': instance.movesAsList,
      'createdAt': instance.createdAt,
      'bestMove': instance.bestMove,
      'biggestScoreDifference': instance.biggestScoreDifference,
      'moveOnWhichMistakeHappened': instance.moveOnWhichMistakeHappened,
      'worstMove': instance.worstMove,
    };
