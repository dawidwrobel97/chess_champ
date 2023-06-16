part of 'auth_gate_cubit.dart';

@freezed
class AuthGateState with _$AuthGateState {
  const factory AuthGateState({
    @Default(Status.initial) Status status,
    @Default(true) bool isLoginPage,
    String? errorMessage,
    User? user,
  }) = _AuthGateState;
}
