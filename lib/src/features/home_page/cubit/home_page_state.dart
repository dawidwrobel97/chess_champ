part of 'home_page_cubit.dart';

@freezed
class HomePageState with _$HomePageState {
  const HomePageState._();
  const factory HomePageState({
    @Default(Status.initial) Status status,
    @Default(false) bool dropDownMenuIsActive,
    String? errorMessage,
    List<ChessGameModel>? listOfChessGamesModels,
    bool? gameGotAddedToFavourites,
  }) = _HomePageState;

  // @override
  // List<Object?> get props =>
  //     [status, listOfChessGamesModels, errorMessage, dropDownMenuIsActive];
}
