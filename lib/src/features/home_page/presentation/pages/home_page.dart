import 'package:chess_app/src/app_theme/app_theme.dart';
import 'package:chess_app/src/common_widgets/app_bar.dart';
import 'package:chess_app/src/core/enums/enums.dart';
import 'package:chess_app/src/features/auth_gate/presentation/cubit/cubit/auth_gate_cubit.dart';
import 'package:chess_app/src/features/home_page/data/data_sources/chess_game_data_source.dart';
import 'package:chess_app/src/features/home_page/data/repositories/user_chess_games_repository.dart';
import 'package:chess_app/src/features/home_page/presentation/cubits/home_page_cubit/home_page_cubit.dart';
import 'package:chess_app/src/features/home_page/presentation/widgets/home_page_widgets/chess_games_list.dart';
import 'package:chess_app/src/features/home_page/presentation/widgets/home_page_widgets/search_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChessHomePage extends StatefulWidget {
  const ChessHomePage({super.key});

  @override
  State<ChessHomePage> createState() => ChessHomePageState();
}

class ChessHomePageState extends State<ChessHomePage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomePageCubit(UserChessGamesRepository(ChessGameDataSource()))
            ..start(),
      child: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          final chessGamesModels = state.listOfChessGamesModels;
          return Builder(builder: (context) {
            switch (state.status) {
              case (Status.initial):
                return _HomePageScaffold(
                  name: null,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SearchTextField(
                          textEditingController: _textEditingController),
                      Padding(
                        padding: const EdgeInsets.all(80.0),
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<AuthGateCubit>().signOut();
                          },
                          child: const Text('Sign out'),
                        ),
                      ),
                    ],
                  ),
                );
              case (Status.loading):
                return const _HomePageScaffold(
                  name: null,
                  padding: EdgeInsets.all(8),
                  child: _CircularLoadingIndicator(),
                );
              case (Status.error):
                return _HomePageScaffold(
                  name: null,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      SearchTextField(
                        textEditingController: _textEditingController,
                      ),
                      Text(state.errorMessage!),
                    ],
                  ),
                );
              case (Status.success):
                return _HomePageScaffold(
                  name: chessGamesModels![0].userId,
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: Column(
                    children: [
                      const _DropDownMenu(),
                      ChessGamesList(chessGamesModels: chessGamesModels),
                    ],
                  ),
                );
            }
          });
        },
      ),
    );
  }
}

class _HomePageScaffold extends StatelessWidget {
  const _HomePageScaffold(
      {required this.child, required this.name, required this.padding});

  final Widget child;
  final String? name;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: HomePageAppBar(
        name: name,
      ),
      body: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}

class _DropDownMenu extends StatelessWidget {
  const _DropDownMenu();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: state.dropDownMenuIsActive == true ? 100 : 10,
          width: MediaQuery.of(context).size.width / 1.5,
          decoration: BoxDecoration(
              border: Border.all(
                color: AppTheme.borderColor,
              ),
              color: AppTheme.contanierColor),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Delete user?',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          context.read<HomePageCubit>().deleteAllCurrentGames();
                        },
                        child: const Icon(
                          Icons.delete,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthGateCubit>().signOut();
                    },
                    child: const Text('Sign out'),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CircularLoadingIndicator extends StatelessWidget {
  const _CircularLoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox.expand(
        child: Column(
          children: const [
            Expanded(
              flex: 3,
              child: SizedBox(),
            ),
            CircularProgressIndicator(color: Colors.blue),
            Expanded(
              flex: 4,
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
