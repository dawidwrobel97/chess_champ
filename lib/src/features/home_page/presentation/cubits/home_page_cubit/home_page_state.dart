part of 'home_page_cubit.dart';

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState({
    required Status status,
    List<ChessGameModel>? listOfChessGamesModels,
    String? errorMessage,
  }) = _HomePageState;
}
