import 'package:bloc_test/bloc_test.dart';
import 'package:chess_app/src/core/enums.dart';
import 'package:chess_app/src/features/auth_gate/presentation/cubit/auth_gate_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'mock.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

void main() async {
  setupFirebaseAuthMocks();
  await Firebase.initializeApp();

  late AuthGateCubit sut;
  late User user;
  late FirebaseAuth fb;

  setUp(() {
    sut = AuthGateCubit();
    user = MockUser();
    fb = MockFirebaseAuth();
  });

  group('start', () {
    group('success', () {
      setUp(() {
        when(() => fb.authStateChanges()).thenAnswer(
          (_) => Stream.value(user),
        );
      });
      blocTest(
          'Should emit AuthGateState with Status.loading, then emit AuthGateState with Status.success, user with results and an errorMessage with empty string',
          build: () => sut,
          act: (cubit) => cubit.start(),
          expect: () => [
                const AuthGateState(status: Status.loading),
                AuthGateState(
                  status: Status.success,
                  user: user,
                  errorMessage: '',
                )
              ]);
    });
  });
}
