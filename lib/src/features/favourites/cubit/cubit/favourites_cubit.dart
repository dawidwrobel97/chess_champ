import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chess_app/src/core/enums.dart';
import 'package:chess_app/src/domain/models/chess_game_model.dart';
import 'package:chess_app/src/domain/repositories/favourites_page_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'favourites_state.dart';
part 'favourites_cubit.freezed.dart';

@injectable
class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit({required this.favouritesPageRepository})
      : super(const FavouritesState());

  StreamSubscription? _streamSubscription;
  FavouritesPageRepository favouritesPageRepository;

  Future<void> start() async {
    try {
      emit(state.copyWith(status: Status.loading));
      _streamSubscription = favouritesPageRepository
          .getUserChessGamesStream()
          .listen((listOfChessGamesModels) {
        if (listOfChessGamesModels.isEmpty) {
          emit(state.copyWith(status: Status.initial));
        } else {
          emit(
            state.copyWith(
              listOfChessGamesModels: listOfChessGamesModels,
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

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
