// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chess_game_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChessGameModel _$ChessGameModelFromJson(Map<String, dynamic> json) {
  return _ChessGameModel.fromJson(json);
}

/// @nodoc
mixin _$ChessGameModel {
  @JsonKey(name: 'id')
  String get gameId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get lastFen => throw _privateConstructorUsedError;
  dynamic get players => throw _privateConstructorUsedError;
  @JsonKey(name: 'analysis')
  List<dynamic> get movesAnalysis => throw _privateConstructorUsedError;
  List<dynamic> get movesAsList => throw _privateConstructorUsedError;
  int get createdAt => throw _privateConstructorUsedError;
  List<dynamic>? get bestMove => throw _privateConstructorUsedError;
  set bestMove(List<dynamic>? value) => throw _privateConstructorUsedError;
  double? get biggestScoreDifference => throw _privateConstructorUsedError;
  set biggestScoreDifference(double? value) =>
      throw _privateConstructorUsedError;
  int? get moveOnWhichMistakeHappened => throw _privateConstructorUsedError;
  set moveOnWhichMistakeHappened(int? value) =>
      throw _privateConstructorUsedError;
  String? get worstMove => throw _privateConstructorUsedError;
  set worstMove(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChessGameModelCopyWith<ChessGameModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChessGameModelCopyWith<$Res> {
  factory $ChessGameModelCopyWith(
          ChessGameModel value, $Res Function(ChessGameModel) then) =
      _$ChessGameModelCopyWithImpl<$Res, ChessGameModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String gameId,
      String userId,
      String lastFen,
      dynamic players,
      @JsonKey(name: 'analysis') List<dynamic> movesAnalysis,
      List<dynamic> movesAsList,
      int createdAt,
      List<dynamic>? bestMove,
      double? biggestScoreDifference,
      int? moveOnWhichMistakeHappened,
      String? worstMove});
}

/// @nodoc
class _$ChessGameModelCopyWithImpl<$Res, $Val extends ChessGameModel>
    implements $ChessGameModelCopyWith<$Res> {
  _$ChessGameModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameId = null,
    Object? userId = null,
    Object? lastFen = null,
    Object? players = freezed,
    Object? movesAnalysis = null,
    Object? movesAsList = null,
    Object? createdAt = null,
    Object? bestMove = freezed,
    Object? biggestScoreDifference = freezed,
    Object? moveOnWhichMistakeHappened = freezed,
    Object? worstMove = freezed,
  }) {
    return _then(_value.copyWith(
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      lastFen: null == lastFen
          ? _value.lastFen
          : lastFen // ignore: cast_nullable_to_non_nullable
              as String,
      players: freezed == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as dynamic,
      movesAnalysis: null == movesAnalysis
          ? _value.movesAnalysis
          : movesAnalysis // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      movesAsList: null == movesAsList
          ? _value.movesAsList
          : movesAsList // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int,
      bestMove: freezed == bestMove
          ? _value.bestMove
          : bestMove // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      biggestScoreDifference: freezed == biggestScoreDifference
          ? _value.biggestScoreDifference
          : biggestScoreDifference // ignore: cast_nullable_to_non_nullable
              as double?,
      moveOnWhichMistakeHappened: freezed == moveOnWhichMistakeHappened
          ? _value.moveOnWhichMistakeHappened
          : moveOnWhichMistakeHappened // ignore: cast_nullable_to_non_nullable
              as int?,
      worstMove: freezed == worstMove
          ? _value.worstMove
          : worstMove // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChessGameModelCopyWith<$Res>
    implements $ChessGameModelCopyWith<$Res> {
  factory _$$_ChessGameModelCopyWith(
          _$_ChessGameModel value, $Res Function(_$_ChessGameModel) then) =
      __$$_ChessGameModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String gameId,
      String userId,
      String lastFen,
      dynamic players,
      @JsonKey(name: 'analysis') List<dynamic> movesAnalysis,
      List<dynamic> movesAsList,
      int createdAt,
      List<dynamic>? bestMove,
      double? biggestScoreDifference,
      int? moveOnWhichMistakeHappened,
      String? worstMove});
}

/// @nodoc
class __$$_ChessGameModelCopyWithImpl<$Res>
    extends _$ChessGameModelCopyWithImpl<$Res, _$_ChessGameModel>
    implements _$$_ChessGameModelCopyWith<$Res> {
  __$$_ChessGameModelCopyWithImpl(
      _$_ChessGameModel _value, $Res Function(_$_ChessGameModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameId = null,
    Object? userId = null,
    Object? lastFen = null,
    Object? players = freezed,
    Object? movesAnalysis = null,
    Object? movesAsList = null,
    Object? createdAt = null,
    Object? bestMove = freezed,
    Object? biggestScoreDifference = freezed,
    Object? moveOnWhichMistakeHappened = freezed,
    Object? worstMove = freezed,
  }) {
    return _then(_$_ChessGameModel(
      null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String,
      null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      null == lastFen
          ? _value.lastFen
          : lastFen // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as dynamic,
      null == movesAnalysis
          ? _value.movesAnalysis
          : movesAnalysis // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      null == movesAsList
          ? _value.movesAsList
          : movesAsList // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int,
      freezed == bestMove
          ? _value.bestMove
          : bestMove // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      freezed == biggestScoreDifference
          ? _value.biggestScoreDifference
          : biggestScoreDifference // ignore: cast_nullable_to_non_nullable
              as double?,
      freezed == moveOnWhichMistakeHappened
          ? _value.moveOnWhichMistakeHappened
          : moveOnWhichMistakeHappened // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == worstMove
          ? _value.worstMove
          : worstMove // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChessGameModel extends _ChessGameModel {
  _$_ChessGameModel(
      @JsonKey(name: 'id') this.gameId,
      this.userId,
      this.lastFen,
      this.players,
      @JsonKey(name: 'analysis') this.movesAnalysis,
      this.movesAsList,
      this.createdAt,
      this.bestMove,
      this.biggestScoreDifference,
      this.moveOnWhichMistakeHappened,
      this.worstMove)
      : super._();

  factory _$_ChessGameModel.fromJson(Map<String, dynamic> json) =>
      _$$_ChessGameModelFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String gameId;
  @override
  final String userId;
  @override
  final String lastFen;
  @override
  final dynamic players;
  @override
  @JsonKey(name: 'analysis')
  final List<dynamic> movesAnalysis;
  @override
  final List<dynamic> movesAsList;
  @override
  final int createdAt;
  @override
  List<dynamic>? bestMove;
  @override
  double? biggestScoreDifference;
  @override
  int? moveOnWhichMistakeHappened;
  @override
  String? worstMove;

  @override
  String toString() {
    return 'ChessGameModel(gameId: $gameId, userId: $userId, lastFen: $lastFen, players: $players, movesAnalysis: $movesAnalysis, movesAsList: $movesAsList, createdAt: $createdAt, bestMove: $bestMove, biggestScoreDifference: $biggestScoreDifference, moveOnWhichMistakeHappened: $moveOnWhichMistakeHappened, worstMove: $worstMove)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChessGameModelCopyWith<_$_ChessGameModel> get copyWith =>
      __$$_ChessGameModelCopyWithImpl<_$_ChessGameModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChessGameModelToJson(
      this,
    );
  }
}

abstract class _ChessGameModel extends ChessGameModel {
  factory _ChessGameModel(
      @JsonKey(name: 'id') final String gameId,
      final String userId,
      final String lastFen,
      final dynamic players,
      @JsonKey(name: 'analysis') final List<dynamic> movesAnalysis,
      final List<dynamic> movesAsList,
      final int createdAt,
      List<dynamic>? bestMove,
      double? biggestScoreDifference,
      int? moveOnWhichMistakeHappened,
      String? worstMove) = _$_ChessGameModel;
  _ChessGameModel._() : super._();

  factory _ChessGameModel.fromJson(Map<String, dynamic> json) =
      _$_ChessGameModel.fromJson;

  @override
  @JsonKey(name: 'id')
  String get gameId;
  @override
  String get userId;
  @override
  String get lastFen;
  @override
  dynamic get players;
  @override
  @JsonKey(name: 'analysis')
  List<dynamic> get movesAnalysis;
  @override
  List<dynamic> get movesAsList;
  @override
  int get createdAt;
  @override
  List<dynamic>? get bestMove;
  set bestMove(List<dynamic>? value);
  @override
  double? get biggestScoreDifference;
  set biggestScoreDifference(double? value);
  @override
  int? get moveOnWhichMistakeHappened;
  set moveOnWhichMistakeHappened(int? value);
  @override
  String? get worstMove;
  set worstMove(String? value);
  @override
  @JsonKey(ignore: true)
  _$$_ChessGameModelCopyWith<_$_ChessGameModel> get copyWith =>
      throw _privateConstructorUsedError;
}
