import 'package:bloc_test/bloc_test.dart';
import 'package:chess_app/src/core/enums.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:chess_app/src/features/home_page/presentation/cubits/home_page_cubit/home_page_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:chess_app/src/features/home_page/domain/repositories/user_chess_games_repository.dart';

class MockUserChessGamesRepository extends Mock
    implements UserChessGamesRepository {}

void main() {
  late HomePageCubit sut;
  late UserChessGamesRepository repository;

  setUp(() {
    repository = MockUserChessGamesRepository();
    sut = HomePageCubit(userChessGamesRepository: repository);
  });

  group('start', () {
    group('should call getUserChessStream() method', () {
      setUp(() => when(() => repository.getUserChessGamesStream())
          .thenAnswer((_) => Stream.value([])));
      blocTest('should call getUserChessStream() method',
          build: () => sut,
          act: (cubit) => cubit.start(),
          verify: (_) => {
                verify(
                  () => repository.getUserChessGamesStream(),
                ).called(1)
              });
    });
    group('succes', () {
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
                      'c5c6')
                ]));
      });
      blocTest(
          'Emits HomePageState with Status.loading, then emits the list of chess games with Status.success and dropDownMenuIsActive: false',
          build: () => sut,
          act: (cubit) => cubit.start(),
          expect: () => [
                const HomePageState(
                  status: Status.loading,
                ),
                HomePageState(
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
                        'c5c6')
                  ],
                  status: Status.success,
                  dropDownMenuIsActive: false,
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
                const HomePageState(status: Status.loading),
                const HomePageState(
                  status: Status.error,
                  errorMessage: 'test-error',
                ),
              ]);
    });
  });

  group('deleteAllCurrentGames', () {
    group('Should call deleteAllCurrentGames() method', () {
      setUp(() {
        when(() => repository.deleteAllCurrentGames())
            .thenAnswer((_) async => []);
      });
      blocTest('Should call deleteAllCurrentGames() method',
          build: () => sut,
          act: (cubit) => cubit.deleteAllCurrentGames(),
          verify: (_) =>
              {verify(() => repository.deleteAllCurrentGames()).called(1)});
    });
    group('success', () {
      setUp(() {
        when(() => repository.deleteAllCurrentGames())
            .thenAnswer((_) async => []);
      });
      blocTest(
        'Should emit the method deleteAllCurrentGames() and emit HomePageStatus with Status.initial',
        build: () => sut,
        act: (cubit) => cubit.deleteAllCurrentGames(),
        expect: () => [const HomePageState(status: Status.initial)],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => repository.deleteAllCurrentGames())
            .thenThrow('test-error');
      });
      blocTest(
        'Should emit the method deleteAllCurrentGames() and emit HomePageStatus with Status.initial',
        build: () => sut,
        act: (cubit) => cubit.deleteAllCurrentGames(),
        expect: () => [const HomePageState(status: Status.error,errorMessage: 'test-error')],
      );
    });
  });
}
