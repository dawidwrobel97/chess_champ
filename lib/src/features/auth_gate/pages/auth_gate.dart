import 'package:chess_app/src/app_theme/app_theme.dart';
import 'package:chess_app/src/common_widgets/app_bar.dart';
import 'package:chess_app/src/core/injection_container.dart';
import 'package:chess_app/src/features/auth_gate/cubit/auth_gate_cubit.dart';
import 'package:chess_app/src/features/home_page/pages/home_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthGateCubit>()..start(),
      child: BlocConsumer<AuthGateCubit, AuthGateState>(
        listener: (context, state) {},
        builder: (context, state) {
          final user = state.user;
          if (user == null) {
            return _AuthPage(state: state);
          } else {
            return const ChessHomePage();
          }
        },
      ),
    );
  }
}

class _AuthPage extends StatelessWidget {
  _AuthPage({required this.state});

  final AuthGateState state;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor: AppTheme.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: Column(
            children: [
              Image.asset(
                'lib/src/assets/images/logo5.png',
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Chess Champ',
                  style: GoogleFonts.bebasNeue(
                    textStyle: const TextStyle(fontSize: 40),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              _LogInMenu(
                  emailController: emailController,
                  passwordController: passwordController,
                  state: state),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogInMenu extends StatelessWidget {
  const _LogInMenu({
    required this.emailController,
    required this.passwordController,
    required this.state,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final AuthGateState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _EmailTextField(emailController: emailController),
        const SizedBox(height: 10),
        _PasswordTextField(passwordController: passwordController),
        const SizedBox(height: 5),
        _LogInButton(
            state: state,
            emailController: emailController,
            passwordController: passwordController),
        const SizedBox(height: 10),
        _SignUpRichText(state: state),
        const SizedBox(height: 10),
        Text(
          state.errorMessage ?? '',
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField({
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          filled: true,
          fillColor: AppTheme.lighterContainerColor,
          hintText: 'E-mail'),
      controller: emailController,
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField({
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          filled: true,
          fillColor: AppTheme.lighterContainerColor,
          hintText: 'Password'),
      controller: passwordController,
      obscureText: true,
    );
  }
}

class _LogInButton extends StatelessWidget {
  const _LogInButton({
    required this.state,
    required this.emailController,
    required this.passwordController,
  });

  final AuthGateState state;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (state.isLoginPage == true) {
          context.read<AuthGateCubit>().signIn(
              emailController.text.trim(), passwordController.text.trim());
        } else {
          context.read<AuthGateCubit>().createAccount(
              emailController.text.trim(), passwordController.text.trim());
        }
      },
      child: Text(
        state.isLoginPage == true ? 'Log In' : 'Sign Up',
      ),
    );
  }
}

class _SignUpRichText extends StatelessWidget {
  const _SignUpRichText({
    required this.state,
  });

  final AuthGateState state;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        text: state.isLoginPage == true
            ? 'No account?  '
            : 'Already have an account? ',
        children: [
          TextSpan(
              text: state.isLoginPage == true ? 'Sign Up' : 'Log In instead',
              style: const TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.blue,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.read<AuthGateCubit>().switchLoginAndSignUp();
                })
        ],
      ),
    );
  }
}
