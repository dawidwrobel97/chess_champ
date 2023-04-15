part of 'home_page_cubit.dart';

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState({
    @Default(Status.initial) Status status,
    @Default(false) bool dropDownMenuIsActive,
    String? errorMessage,
    List<ChessGameModel>? listOfChessGamesModels,
  }) = _HomePageState;
}
