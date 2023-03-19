part of 'auth_gate_cubit.dart';

@freezed
class AuthGateState with _$AuthGateState {
  const factory AuthGateState({
    required Status status,
  }) = _AuthGateState;
}
