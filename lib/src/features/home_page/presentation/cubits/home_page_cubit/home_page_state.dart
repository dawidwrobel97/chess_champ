part of 'home_page_cubit.dart';

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState({
    required Status status,
    required bool dropDownMenuIsActive,
    String? errorMessage,
    List<ChessGameModel>? listOfChessGamesModels,

  }) = _HomePageState;
}
