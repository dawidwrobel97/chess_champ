import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chess_app/src/core/enums/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_gate_cubit.freezed.dart';
part 'auth_gate_state.dart';

class AuthGateCubit extends Cubit<AuthGateState> {
  AuthGateCubit()
      : super(const AuthGateState(
          status: Status.initial,
          isLoginPage: true,
        ));

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      state.copyWith(
        status: Status.loading,
      ),
    );
    _streamSubscription =
        FirebaseAuth.instance.authStateChanges().listen((user) {
      emit(
        state.copyWith(
          status: Status.success,
          user: user,
          errorMessage: '',
        ),
      );
    })
          ..onError((error) {
            emit(
              state.copyWith(
                status: Status.error,
                errorMessage: error.toString(),
              ),
            );
          });
  }

  Future<void> createAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      ));
    } catch (error) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (error) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> switchLoginAndSignUp() async {
    try {
      if (state.isLoginPage == true) {
        emit(state.copyWith(
          isLoginPage: false,
          errorMessage: '',
        ));
      } else {
        emit(state.copyWith(
          isLoginPage: true,
          errorMessage: '',
        ));
      }
    } catch (error) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
