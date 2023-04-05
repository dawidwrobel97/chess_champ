import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chess_app/src/core/enums.dart';
import 'package:chess_app/src/features/home_page/data/repositories/user_chess_games_repository.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_page_cubit.freezed.dart';
part 'home_page_state.dart';

@injectable
class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit({ required
    this.userChessGamesRepository,
}) : super(const HomePageState(
          status: Status.initial,
          dropDownMenuIsActive: false,
        ));

  final UserChessGamesRepository userChessGamesRepository;
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription = userChessGamesRepository
        .getUserChessGamesStream()
        .listen((listOfChessGamesModels) {
      if (listOfChessGamesModels.isEmpty) {
        emit(state.copyWith(status: Status.initial));
      } else {
        emit(
          state.copyWith(
            listOfChessGamesModels: listOfChessGamesModels,
            dropDownMenuIsActive: false,
            status: Status.success,
          ),
        );
      }
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

  Future<void> deleteAllCurrentGames() async {
    await userChessGamesRepository.deleteAllCurrentGames();
    emit(state.copyWith(status: Status.initial));
  }

  Future<void> getUserChessGamesFromId(String id) async {
    emit(state.copyWith(status: Status.loading));
    userChessGamesRepository.addUserGamesIntoFirebase(id);
  }

  Future<void> dropDownMenu() async {
    if (state.dropDownMenuIsActive == false) {
      emit(state.copyWith(dropDownMenuIsActive: true));
    } else if (state.dropDownMenuIsActive == true) {
      emit(state.copyWith(dropDownMenuIsActive: false));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
