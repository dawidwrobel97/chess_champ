import 'package:chess_app/src/app_theme/app_theme.dart';
import 'package:chess_app/src/common_widgets/app_bar.dart';
import 'package:chess_app/src/features/auth_gate/presentation/cubit/cubit/auth_gate_cubit.dart';
import 'package:chess_app/src/features/home_page/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGate extends StatelessWidget {
  AuthGate({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthGateCubit()..start(),
      child: BlocBuilder<AuthGateCubit, AuthGateState>(
        builder: (context, state) {
          final user = state.user;
          if (user == null) {
            return AuthPage(
                emailController: emailController,
                passwordController: passwordController);
          } else {
            return const ChessHomePage();
          }
        },
      ),
    );
  }
}

class AuthPage extends StatelessWidget {
  const AuthPage({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

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
              onPressed: () {},
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
