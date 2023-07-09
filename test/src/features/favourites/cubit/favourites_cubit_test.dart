import 'package:bloc_test/bloc_test.dart';
import 'package:chess_app/src/core/enums.dart';
import 'package:chess_app/src/domain/models/chess_game_model.dart';
import 'package:chess_app/src/domain/repositories/favourites_page_repository.dart';
import 'package:chess_app/src/features/favourites/cubit/favourites_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFavouritesRepository extends Mock implements FavouritesRepository {}

void main() {
  late FavouritesCubit sut;
  late FavouritesRepository repository;

  setUp(() {
    repository = MockFavouritesRepository();
    sut = FavouritesCubit(favouritesRepository: repository);
  });

  group('start', () {
    group('verify method is called', () {
      setUp(
        () => when(() => repository.getUserChessGamesStream()).thenAnswer(
          (_) => Stream.value([]),
        ),
      );
      blocTest('should call getUserChessStream() method once',
          build: () => sut,
          act: (cubit) => cubit.start(),
          verify: (_) => {
                verify(
                  () => repository.getUserChessGamesStream(),
                ).called(1)
              });
    });
    group('succes with ChessGameModel response', () {
      setUp(() {
        when(() => repository.getUserChessGamesStream())
            .thenAnswer((_) => Stream.value([
                  ChessGameModel(
                    'GameId123',
                    'TestUser',
                    'Fen123',
                    'players',
                    ['move1', 'move2'],
                    ['e4', 'e5'],
                    12345,
                    ['d4', 'd5'],
                    100,
                    10,
                    'c5c6',
                    false,
                  )
                ]));
      });
      blocTest(
          'Emits FavouritesState with Status.loading, then emits theListOfChessGames with Status.success and dropDownMenuIsActive: false',
          build: () => sut,
          act: (cubit) => cubit.start(),
          expect: () => [
                const FavouritesState(
                  status: Status.loading,
                ),
                FavouritesState(
                  listOfChessGamesModels: [
                    ChessGameModel(
                      'GameId123',
                      'TestUser',
                      'Fen123',
                      'players',
                      ['move1', 'move2'],
                      ['e4', 'e5'],
                      12345,
                      ['d4', 'd5'],
                      100,
                      10,
                      'c5c6',
                      false,
                    )
                  ],
                  status: Status.success,
                )
              ]);
    });
    group('success with empty response', () {
      setUp(() {
        when(() => repository.getUserChessGamesStream())
            .thenAnswer((_) => Stream.value([]));
      });
      blocTest(
          'Emits FavouritesState with Status.loading, then emits FavouritesState with Status.initial',
          build: () => sut,
          act: (cubit) => cubit.start(),
          expect: () => [
                const FavouritesState(
                  status: Status.loading,
                ),
                const FavouritesState(
                  status: Status.initial,
                )
              ]);
    });
    group('failure', () {
      setUp(() {
        when(() => repository.getUserChessGamesStream())
            .thenThrow('test-error');
      });
      blocTest(
          'Emits Status.loading then emits Status.error with error message',
          build: () => sut,
          act: (cubit) => cubit.start(),
          expect: () => [
                const FavouritesState(status: Status.loading),
                const FavouritesState(
                  status: Status.error,
                  errorMessage: 'test-error',
                ),
              ]);
    });
    group('deleteGame', () {
      group('verify method is called', () {
        setUp(() {
          when(() => repository.deleteGame('id')).thenAnswer((_) async => []);
        });
        blocTest('Should call deleteGame() method once',
            build: () => sut,
            act: (cubit) => cubit.deleteGame('id'),
            verify: (_) =>
                {verify(() => repository.deleteGame('id')).called(1)});
      });
      group('failure', () {
        setUp(() {
          when(() => repository.deleteGame('id'))
              .thenThrow('test-error');
        });
        blocTest(
          'Should emit HomePageStatus with Status.error with errorMessage',
          build: () => sut,
          act: (cubit) => cubit.deleteGame('id'),
          expect: () => [
            const FavouritesState(
              status: Status.error,
              errorMessage: 'test-error',
            )
          ],
        );
      });
    });
  });
}
