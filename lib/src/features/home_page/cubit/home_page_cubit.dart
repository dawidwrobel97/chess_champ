import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chess_app/src/core/enums.dart';
import 'package:chess_app/src/domain/repositories/user_chess_games_repository.dart';
import 'package:chess_app/src/domain/models/chess_game_model.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part 'home_page_cubit.freezed.dart';
part 'home_page_state.dart';

@injectable
class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit({
    required this.userChessGamesRepository,
  }) : super(const HomePageState());

  final UserChessGamesRepository userChessGamesRepository;
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    try {
      emit(state.copyWith(status: Status.loading));
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
      });
    } catch (error) {
      emit(
        state.copyWith(
          errorMessage: error.toString(),
          status: Status.error,
        ),
      );
    }
  }

  Future<void> deleteGame(String id) async {
    try {
      await userChessGamesRepository.deleteGame(id);
    } catch (error) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> deleteAllCurrentGames() async {
    try {
      await userChessGamesRepository.deleteAllCurrentGames();
    } catch (error) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> getUserChessGamesFromId(String id) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final response =
          await userChessGamesRepository.getUserChessGamesFromId(id);
      userChessGamesRepository.addUserGamesIntoFirebase(id, response);
    } on DioError catch (error) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: error.message ==
                  'The request returned an invalid status code of 404.'
              ? 'No player with this username was found!'
              : error.message,
        ),
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

  Future<void> dropDownMenu() async {
    emit(state.copyWith(dropDownMenuIsActive: !state.dropDownMenuIsActive));
  }

  Future<void> saveToFavourites(ChessGameModel chessGameModel) async {
    try {
      final response =
          await userChessGamesRepository.addGameToFavourites(chessGameModel);
      if (response == AddGameToFavourites.added) {
        emit(state.copyWith(
            gameGotAddedToFavourites: AddGameToFavourites.added));
      } else if (response == AddGameToFavourites.repeat) {
        emit(state.copyWith(
            gameGotAddedToFavourites: AddGameToFavourites.repeat));
      } else if (response == AddGameToFavourites.tooManyGames) {
        emit(state.copyWith(
            gameGotAddedToFavourites: AddGameToFavourites.tooManyGames));
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

  Future<void> changeGameGotAddedToFavouritesToNull() async {
    try {
      emit(state.copyWith(gameGotAddedToFavourites: null));
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
