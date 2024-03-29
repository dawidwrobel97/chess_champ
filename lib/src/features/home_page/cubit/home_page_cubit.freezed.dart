// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_page_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomePageState {
  Status get status => throw _privateConstructorUsedError;
  bool get dropDownMenuIsActive => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  List<ChessGameModel>? get listOfChessGamesModels =>
      throw _privateConstructorUsedError;
  Enum? get gameGotAddedToFavourites => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomePageStateCopyWith<HomePageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomePageStateCopyWith<$Res> {
  factory $HomePageStateCopyWith(
          HomePageState value, $Res Function(HomePageState) then) =
      _$HomePageStateCopyWithImpl<$Res, HomePageState>;
  @useResult
  $Res call(
      {Status status,
      bool dropDownMenuIsActive,
      String? errorMessage,
      List<ChessGameModel>? listOfChessGamesModels,
      Enum? gameGotAddedToFavourites});
}

/// @nodoc
class _$HomePageStateCopyWithImpl<$Res, $Val extends HomePageState>
    implements $HomePageStateCopyWith<$Res> {
  _$HomePageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? dropDownMenuIsActive = null,
    Object? errorMessage = freezed,
    Object? listOfChessGamesModels = freezed,
    Object? gameGotAddedToFavourites = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      dropDownMenuIsActive: null == dropDownMenuIsActive
          ? _value.dropDownMenuIsActive
          : dropDownMenuIsActive // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      listOfChessGamesModels: freezed == listOfChessGamesModels
          ? _value.listOfChessGamesModels
          : listOfChessGamesModels // ignore: cast_nullable_to_non_nullable
              as List<ChessGameModel>?,
      gameGotAddedToFavourites: freezed == gameGotAddedToFavourites
          ? _value.gameGotAddedToFavourites
          : gameGotAddedToFavourites // ignore: cast_nullable_to_non_nullable
              as Enum?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HomePageStateCopyWith<$Res>
    implements $HomePageStateCopyWith<$Res> {
  factory _$$_HomePageStateCopyWith(
          _$_HomePageState value, $Res Function(_$_HomePageState) then) =
      __$$_HomePageStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Status status,
      bool dropDownMenuIsActive,
      String? errorMessage,
      List<ChessGameModel>? listOfChessGamesModels,
      Enum? gameGotAddedToFavourites});
}

/// @nodoc
class __$$_HomePageStateCopyWithImpl<$Res>
    extends _$HomePageStateCopyWithImpl<$Res, _$_HomePageState>
    implements _$$_HomePageStateCopyWith<$Res> {
  __$$_HomePageStateCopyWithImpl(
      _$_HomePageState _value, $Res Function(_$_HomePageState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? dropDownMenuIsActive = null,
    Object? errorMessage = freezed,
    Object? listOfChessGamesModels = freezed,
    Object? gameGotAddedToFavourites = freezed,
  }) {
    return _then(_$_HomePageState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      dropDownMenuIsActive: null == dropDownMenuIsActive
          ? _value.dropDownMenuIsActive
          : dropDownMenuIsActive // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      listOfChessGamesModels: freezed == listOfChessGamesModels
          ? _value._listOfChessGamesModels
          : listOfChessGamesModels // ignore: cast_nullable_to_non_nullable
              as List<ChessGameModel>?,
      gameGotAddedToFavourites: freezed == gameGotAddedToFavourites
          ? _value.gameGotAddedToFavourites
          : gameGotAddedToFavourites // ignore: cast_nullable_to_non_nullable
              as Enum?,
    ));
  }
}

/// @nodoc

class _$_HomePageState extends _HomePageState {
  const _$_HomePageState(
      {this.status = Status.initial,
      this.dropDownMenuIsActive = false,
      this.errorMessage,
      final List<ChessGameModel>? listOfChessGamesModels,
      this.gameGotAddedToFavourites})
      : _listOfChessGamesModels = listOfChessGamesModels,
        super._();

  @override
  @JsonKey()
  final Status status;
  @override
  @JsonKey()
  final bool dropDownMenuIsActive;
  @override
  final String? errorMessage;
  final List<ChessGameModel>? _listOfChessGamesModels;
  @override
  List<ChessGameModel>? get listOfChessGamesModels {
    final value = _listOfChessGamesModels;
    if (value == null) return null;
    if (_listOfChessGamesModels is EqualUnmodifiableListView)
      return _listOfChessGamesModels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Enum? gameGotAddedToFavourites;

  @override
  String toString() {
    return 'HomePageState(status: $status, dropDownMenuIsActive: $dropDownMenuIsActive, errorMessage: $errorMessage, listOfChessGamesModels: $listOfChessGamesModels, gameGotAddedToFavourites: $gameGotAddedToFavourites)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HomePageState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.dropDownMenuIsActive, dropDownMenuIsActive) ||
                other.dropDownMenuIsActive == dropDownMenuIsActive) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(
                other._listOfChessGamesModels, _listOfChessGamesModels) &&
            (identical(
                    other.gameGotAddedToFavourites, gameGotAddedToFavourites) ||
                other.gameGotAddedToFavourites == gameGotAddedToFavourites));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      dropDownMenuIsActive,
      errorMessage,
      const DeepCollectionEquality().hash(_listOfChessGamesModels),
      gameGotAddedToFavourites);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HomePageStateCopyWith<_$_HomePageState> get copyWith =>
      __$$_HomePageStateCopyWithImpl<_$_HomePageState>(this, _$identity);
}

abstract class _HomePageState extends HomePageState {
  const factory _HomePageState(
      {final Status status,
      final bool dropDownMenuIsActive,
      final String? errorMessage,
      final List<ChessGameModel>? listOfChessGamesModels,
      final Enum? gameGotAddedToFavourites}) = _$_HomePageState;
  const _HomePageState._() : super._();

  @override
  Status get status;
  @override
  bool get dropDownMenuIsActive;
  @override
  String? get errorMessage;
  @override
  List<ChessGameModel>? get listOfChessGamesModels;
  @override
  Enum? get gameGotAddedToFavourites;
  @override
  @JsonKey(ignore: true)
  _$$_HomePageStateCopyWith<_$_HomePageState> get copyWith =>
      throw _privateConstructorUsedError;
}
