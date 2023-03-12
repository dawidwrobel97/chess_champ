part of 'home_page_cubit.dart';

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState({
    List<ChessGameModel>? listOfChessGamesModels,
    required Status status,
    String? errorMessage,
  }) = _HomePageState;
}
