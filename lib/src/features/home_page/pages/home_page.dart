import 'package:chess_app/src/app_theme/app_theme.dart';
import 'package:chess_app/src/common_widgets/app_bar.dart';
import 'package:chess_app/src/core/enums.dart';
import 'package:chess_app/src/core/injection_container.dart';
import 'package:chess_app/src/features/home_page/cubit/home_page_cubit.dart';
import 'package:chess_app/src/features/home_page/widgets/chess_games_list.dart';
import 'package:chess_app/src/common_widgets/menu_drawer.dart';
import 'package:chess_app/src/features/home_page/widgets/search_textfield.dart';
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
      create: (context) => getIt<HomePageCubit>()..start(),
      child: BlocConsumer<HomePageCubit, HomePageState>(
        listener: (context, state) {
          if (state.gameGotAddedToFavourites == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Game added to favourites'),
                backgroundColor: Colors.green,
              ),
            );
            context
                .read<HomePageCubit>()
                .changeGameGotAddedToFavouritesToNull();
          }
          if (state.gameGotAddedToFavourites == false) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed adding the game'),
                backgroundColor: Colors.red,
              ),
            );
            context
                .read<HomePageCubit>()
                .changeGameGotAddedToFavouritesToNull();
          }
        },
        builder: (context, state) {
          final chessGamesModels = state.listOfChessGamesModels;
          return Builder(builder: (context) {
            switch (state.status) {
              case (Status.initial):
                return _HomePageScaffold(
                  name: null,
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset('lib/src/assets/images/logo5.png'),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const _DropDownMenu(),
                            SearchTextField(
                                textEditingController: _textEditingController),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              case (Status.loading):
                return _HomePageScaffold(
                  name: null,
                  padding: const EdgeInsets.all(8),
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset('lib/src/assets/images/logo5.png'),
                      ),
                      const Center(
                        child: CircularProgressIndicator(color: Colors.blue),
                      )
                    ],
                  ),
                );
              case (Status.error):
                return _HomePageScaffold(
                  name: null,
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset('lib/src/assets/images/logo5.png'),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            const _DropDownMenu(),
                            SearchTextField(
                              textEditingController: _textEditingController,
                            ),
                            Text(state.errorMessage!),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              case (Status.success):
                return _HomePageScaffold(
                  name: chessGamesModels![0].userId,
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset('lib/src/assets/images/logo5.png'),
                      ),
                      Column(
                        children: [
                          const _DropDownMenu(),
                          ChessGamesList(chessGamesModels: chessGamesModels),
                        ],
                      ),
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
      drawer: const MenuDrawer(),
      resizeToAvoidBottomInset: false,
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
          height: state.dropDownMenuIsActive == true ? 45 : 10,
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
                  InkWell(
                    onTap: () {
                      context.read<HomePageCubit>().deleteAllCurrentGames();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Delete user?',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.delete,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
