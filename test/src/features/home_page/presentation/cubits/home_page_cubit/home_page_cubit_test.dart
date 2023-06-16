import 'package:bloc_test/bloc_test.dart';
import 'package:chess_app/src/core/enums.dart';
import 'package:chess_app/src/domain/models/chess_game_model.dart';
import 'package:chess_app/src/features/home_page/presentation/cubit/home_page_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:chess_app/src/domain/repositories/user_chess_games_repository.dart';

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
          'Emits HomePageState with Status.loading, then emits theListOfChessGames with Status.success and dropDownMenuIsActive: false',
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
                      'c5c6',
                      false,
                    )
                  ],
                  status: Status.success,
                  dropDownMenuIsActive: false,
                )
              ]);
    });
    group('success with empty response', () {
      setUp(() {
        when(() => repository.getUserChessGamesStream())
            .thenAnswer((_) => Stream.value([]));
      });
      blocTest(
          'Emits HomePageState with Status.loading, then emits HomePageState with Status.initial',
          build: () => sut,
          act: (cubit) => cubit.start(),
          expect: () => [
                const HomePageState(
                  status: Status.loading,
                ),
                const HomePageState(
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
                const HomePageState(status: Status.loading),
                const HomePageState(
                  status: Status.error,
                  errorMessage: 'test-error',
                ),
              ]);
    });
  });

  group('deleteAllCurrentGames', () {
    group('verify method is called', () {
      setUp(() {
        when(() => repository.deleteAllCurrentGames())
            .thenAnswer((_) async => []);
      });
      blocTest('Should call deleteAllCurrentGames() method once',
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
        'Should emit HomePageStatus with Status.initial',
        build: () => sut,
        act: (cubit) => cubit.deleteAllCurrentGames(),
        expect: () => [
          const HomePageState(
            status: Status.initial,
          ),
        ],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => repository.deleteAllCurrentGames()).thenThrow('test-error');
      });
      blocTest(
        'Should emit HomePageStatus with Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => cubit.deleteAllCurrentGames(),
        expect: () => [
          const HomePageState(
            status: Status.error,
            errorMessage: 'test-error',
          )
        ],
      );
    });
  });
  group('getUserChessGamesFromId', () {
    group('verify methods are called', () {
      setUp(() {
        when(() => repository.getUserChessGamesFromId('id'))
            .thenAnswer((_) async => 'response');
        when(() => repository.addUserGamesIntoFirebase('id', 'response'))
            .thenAnswer((_) async => '');
      });
      blocTest(
          'Should call getUserChessGamesFromId() method once and addUserGamesIntoFirebase() method once',
          build: () => sut,
          act: (cubit) => cubit.getUserChessGamesFromId('id'),
          verify: (_) => {
                verify(() => repository.getUserChessGamesFromId('id'))
                    .called(1),
                verify(() =>
                        repository.addUserGamesIntoFirebase('id', 'response'))
                    .called(1)
              });
    });
    group('success', () {
      setUp(() {
        when(() => repository.getUserChessGamesFromId('id'))
            .thenAnswer((_) async => 'response');
        when(() => repository.addUserGamesIntoFirebase('id', 'response'))
            .thenAnswer((_) async => []);
      });
      blocTest(
        'Should emit HomePageState with Status.loading',
        build: () => sut,
        act: (cubit) => cubit.getUserChessGamesFromId('id'),
        expect: () => [
          const HomePageState(
            status: Status.loading,
          ),
        ],
      );
    });
    group('failure', () {
      group('getUserChessGamesFromId failure', () {
        setUp(() {
          when(() => repository.getUserChessGamesFromId('id'))
              .thenThrow('test-error');
          when(() => repository.addUserGamesIntoFirebase('id', 'response'))
              .thenAnswer((_) async => []);
        });
        blocTest(
          'Should emit the HomePageState with Status.loading then HomePageState with Status.error and errorMessage',
          build: () => sut,
          act: (cubit) => cubit.getUserChessGamesFromId('id'),
          expect: () => [
            const HomePageState(status: Status.loading),
            const HomePageState(
              status: Status.error,
              errorMessage: 'test-error',
            )
          ],
        );
      });
      group('addUserGamesIntoFirebase failure', () {
        group('addUserGamesIntoFirebase standard failure', () {
          setUp(() {
            when(() => repository.getUserChessGamesFromId('id'))
                .thenAnswer((_) async => 'response');
            when(() => repository.addUserGamesIntoFirebase('id', 'response'))
                .thenThrow('error-test');
          });
          blocTest(
            'Should emit the HomePageState with Status.loading then HomePageState with Status.error and errorMessage',
            build: () => sut,
            act: (cubit) => cubit.getUserChessGamesFromId('id'),
            expect: () => [
              const HomePageState(status: Status.loading),
              const HomePageState(
                status: Status.error,
                errorMessage: 'error-test',
              )
            ],
          );
        });
        group('addUserGamesIntoFirebase DioError failure', () {
          setUp(() {
            when(() => repository.getUserChessGamesFromId('id'))
                .thenAnswer((_) async => 'response');
            when(() => repository.addUserGamesIntoFirebase('id', 'response'))
                .thenThrow(DioError(
                    requestOptions: RequestOptions(),
                    message:
                        'The request returned an invalid status code of 404.'));
          });
          blocTest(
            'Should emit the HomePageState with Status.loading then HomePageState with Status.error and errorMessage: No player with this username was found!',
            build: () => sut,
            act: (cubit) => cubit.getUserChessGamesFromId('id'),
            expect: () => [
              const HomePageState(status: Status.loading),
              const HomePageState(
                status: Status.error,
                errorMessage: 'No player with this username was found!',
              )
            ],
          );
        });
      });
    });
  });
  group('dropDownMenu', () {
    blocTest(
      'Should emit the HomePageState with dropDownMenuIsActive with opposite boolean',
      build: () => sut,
      act: (cubit) => cubit.dropDownMenu(),
      expect: () => [const HomePageState(dropDownMenuIsActive: true)],
    );
  });
}
