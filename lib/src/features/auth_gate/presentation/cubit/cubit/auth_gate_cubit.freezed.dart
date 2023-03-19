// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_gate_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthGateState {
  Status get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthGateStateCopyWith<AuthGateState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthGateStateCopyWith<$Res> {
  factory $AuthGateStateCopyWith(
          AuthGateState value, $Res Function(AuthGateState) then) =
      _$AuthGateStateCopyWithImpl<$Res, AuthGateState>;
  @useResult
  $Res call({Status status});
}

/// @nodoc
class _$AuthGateStateCopyWithImpl<$Res, $Val extends AuthGateState>
    implements $AuthGateStateCopyWith<$Res> {
  _$AuthGateStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AuthGateStateCopyWith<$Res>
    implements $AuthGateStateCopyWith<$Res> {
  factory _$$_AuthGateStateCopyWith(
          _$_AuthGateState value, $Res Function(_$_AuthGateState) then) =
      __$$_AuthGateStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Status status});
}

/// @nodoc
class __$$_AuthGateStateCopyWithImpl<$Res>
    extends _$AuthGateStateCopyWithImpl<$Res, _$_AuthGateState>
    implements _$$_AuthGateStateCopyWith<$Res> {
  __$$_AuthGateStateCopyWithImpl(
      _$_AuthGateState _value, $Res Function(_$_AuthGateState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_$_AuthGateState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
    ));
  }
}

/// @nodoc

class _$_AuthGateState implements _AuthGateState {
  const _$_AuthGateState({required this.status});

  @override
  final Status status;

  @override
  String toString() {
    return 'AuthGateState(status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthGateState &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthGateStateCopyWith<_$_AuthGateState> get copyWith =>
      __$$_AuthGateStateCopyWithImpl<_$_AuthGateState>(this, _$identity);
}

abstract class _AuthGateState implements AuthGateState {
  const factory _AuthGateState({required final Status status}) =
      _$_AuthGateState;

  @override
  Status get status;
  @override
  @JsonKey(ignore: true)
  _$$_AuthGateStateCopyWith<_$_AuthGateState> get copyWith =>
      throw _privateConstructorUsedError;
}
