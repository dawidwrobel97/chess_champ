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

class MockUserCredential extends Mock implements UserCredential {}

void main() async {
  setupFirebaseAuthMocks();
  await Firebase.initializeApp();

  late AuthGateCubit sut;
  late User user;
  late FirebaseAuth firebaseAuth;
  late UserCredential userCredential;

  setUp(() {
    user = MockUser();
    firebaseAuth = MockFirebaseAuth();
    userCredential = MockUserCredential();
    sut = AuthGateCubit(firebaseAuth: firebaseAuth);
  });

  group('start', () {
    group('verify method is called', () {
      setUp(() {
        when(() => firebaseAuth.authStateChanges()).thenAnswer(
          (_) => Stream.value(user),
        );
      });
      blocTest('Should call authStateChanges() method  once',
          build: () => sut,
          act: (cubit) => cubit.start(),
          verify: (_) => {
                verify(
                  () => firebaseAuth.authStateChanges(),
                ).called(1)
              });
    });
    group('success', () {
      setUp(() {
        when(() => firebaseAuth.authStateChanges()).thenAnswer(
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
    group('failure', () {
      setUp(() {
        when(() => firebaseAuth.authStateChanges()).thenThrow('test-error');
      });
      blocTest('Should emit Status.loading then Status.error with errorMessage',
          build: () => sut,
          act: (cubit) => cubit.start(),
          expect: () => [
                const AuthGateState(status: Status.loading),
                const AuthGateState(
                    status: Status.error, errorMessage: 'test-error'),
              ]);
    });
  });
  group('createAccount', () {
    group('verify method is called', () {
      setUp(() {
        when(() => firebaseAuth.createUserWithEmailAndPassword(
            email: 'email', password: 'password')).thenAnswer(
          (_) async => userCredential,
        );
      });
      blocTest('Should call createUserWithEmailAndPassword() method  once',
          build: () => sut,
          act: (cubit) => cubit.createAccount('email', 'password'),
          verify: (_) => {
                verify(
                  () => firebaseAuth.createUserWithEmailAndPassword(
                      email: 'email', password: 'password'),
                ).called(1)
              });
    });

    group('failure', () {
      setUp(() {
        when(() => firebaseAuth.createUserWithEmailAndPassword(
            email: 'email', password: 'password')).thenThrow('test-error');
        blocTest(
          'Should emit AuthGateState with Status.error and errorMessage',
          build: () => sut,
          act: (cubit) => cubit.start(),
          expect: () => [const AuthGateState(status: Status.error)],
        );
      });
    });
  });
}
