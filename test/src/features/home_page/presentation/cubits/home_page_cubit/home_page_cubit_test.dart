import 'package:bloc_test/bloc_test.dart';
import 'package:chess_app/src/core/enums.dart';
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

  group('getUserChessGamesFormId', () {
    blocTest('',
        build: () => sut,
        act: (cubit) => cubit.getUserChessGamesFromId('123'),
        expect: () => [
              const HomePageState(status: Status.loading),
            ]);
  });

  // group('start', () {
  //   setUp(() {});

  //   blocTest(
  //     'emits Status.loading, then if listOfChessGamesModels is empty emits Status.initial, else emits Status.success with results and dropDownMenuIsActive on false',
  //     build: () => sut,
  //     act: (cubit) => cubit.start(),
  //     expect: () => [],
  //   );
  // });
  // [
//             ChessGameModel(
//                 'GameId123',
//                 'TestUser',
//                 'Fen123',
//                 'players',
//                 ['move1', 'move2'],
//                 ['e4', 'e5'],
//                 12345,
//                 ['d4', 'd5'],
//                 100,
//                 10,
//                 'c5c6')
//           ]
}
