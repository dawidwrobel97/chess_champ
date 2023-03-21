import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chess_app/src/core/enums/enums.dart';
import 'package:chess_app/src/features/home_page/data/repositories/user_chess_games_repository.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_page_cubit.freezed.dart';
part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(
    this._userChessGamesRepository,
  ) : super(const HomePageState(status: Status.initial));

  final UserChessGamesRepository _userChessGamesRepository;
  StreamSubscription? _streamSubscription;

  Future<void> getUserChessGamesFromId(String id) async {
    emit(state.copyWith(status: Status.loading));
    // Remove all currently saved games before getting new ones
    _userChessGamesRepository.deleteAllCurrentGames();
    _userChessGamesRepository.addUserGamesIntoFirebase(id);
    _streamSubscription = _userChessGamesRepository
        .getUserChessGamesFromIdStream(id)
        .listen((games) {
      emit(
        state.copyWith(
          listOfChessGamesModels: games,
          status: Status.success,
        ),
      );
    })
      ..onError((error) {
        emit(
          state.copyWith(
            errorMessage: error.toString(),
            status: Status.error,
          ),
        );
      });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
