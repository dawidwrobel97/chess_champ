part of 'favourites_cubit.dart';

@freezed
class FavouritesState with _$FavouritesState {
  const factory FavouritesState({
    @Default(Status.initial) Status status,
    String? errorMessage,
    List<ChessGameModel>? listOfChessGamesModels,
  }) = _FavouritesState;
}
