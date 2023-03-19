import 'package:bloc/bloc.dart';
import 'package:chess_app/src/core/enums/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_gate_state.dart';
part 'auth_gate_cubit.freezed.dart';

class AuthGateCubit extends Cubit<AuthGateState> {
  AuthGateCubit() : super(const AuthGateState(status: Status.initial));
}
