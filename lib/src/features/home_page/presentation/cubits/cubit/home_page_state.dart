part of 'home_page_cubit.dart';

@immutable
class HomePageState {
  const HomePageState({
    this.listOfChessGamesModels,
    this.status = Status.initial,
    this.errorMessage
  });

  final List<ChessGameModel>? listOfChessGamesModels;
  final Status status;
  final String? errorMessage;
}
