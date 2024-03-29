import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chess_app/src/core/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_gate_cubit.freezed.dart';
part 'auth_gate_state.dart';

@injectable
class AuthGateCubit extends Cubit<AuthGateState> {
  AuthGateCubit({required this.firebaseAuth}) : super(const AuthGateState());

  final FirebaseAuth firebaseAuth;
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    try {
      emit(state.copyWith(status: Status.loading));
      _streamSubscription = firebaseAuth.authStateChanges().listen((user) {
        emit(
          state.copyWith(
            status: Status.success,
            user: user,
            errorMessage: '',
          ),
        );
      });
    } catch (error) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> createAccount(String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
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
      await firebaseAuth.signInWithEmailAndPassword(
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

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
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
    emit(state.copyWith(
      isLoginPage: !state.isLoginPage,
      errorMessage: '',
    ));
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
