import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chess_app/src/core/enums/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_gate_cubit.freezed.dart';
part 'auth_gate_state.dart';

class AuthGateCubit extends Cubit<AuthGateState> {
  AuthGateCubit() : super(const AuthGateState(status: Status.initial));

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      state.copyWith(
        status: Status.loading,
      ),
    );
    _streamSubscription = FirebaseAuth.instance
        .authStateChanges()
        .listen((user) {
      emit(
        state.copyWith(
          status: Status.success,
          user: user,
        ),
      );
    })
      ..onError((error) {
        emit(
          state.copyWith(status: Status.error, errorMessage: error.toString()),
        );
      });
  }

  Future<void> signIn(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
