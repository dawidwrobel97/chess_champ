import 'package:chess_app/src/app_theme/app_theme.dart';
import 'package:chess_app/src/common_widgets/app_bar.dart';
import 'package:chess_app/src/features/auth_gate/presentation/cubit/cubit/auth_gate_cubit.dart';
import 'package:chess_app/src/features/home_page/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthGateCubit()..start(),
      child: BlocConsumer<AuthGateCubit, AuthGateState>(
        listener: (context, state) {},
        builder: (context, state) {
          final user = state.user;
          if (user == null) {
            return _AuthPage();
          } else {
            return const ChessHomePage();
          }
        },
      ),
    );
  }
}

class _AuthPage extends StatelessWidget {
  _AuthPage();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor: AppTheme.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: AppTheme.lighterContainerColor,
                  hintText: 'E-mail'),
              controller: emailController,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: AppTheme.lighterContainerColor,
                  hintText: 'Password'),
              controller: passwordController,
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                context
                    .read<AuthGateCubit>()
                    .signIn(emailController.text, passwordController.text);
              },
              child: const Text(
                'Confirm',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
