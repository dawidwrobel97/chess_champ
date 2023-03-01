import 'package:chess_app/src/common_widgets/app_bar.dart';
import 'package:chess_app/src/features/home_page/data/data_sources/chess_game_data_source.dart';
import 'package:chess_app/src/features/home_page/data/repositories/chess_game_repository.dart';
import 'package:chess_app/src/features/home_page/presentation/cubits/cubit/home_page_cubit.dart';
import 'package:chess_app/src/features/home_page/presentation/widgets/chess_games_list.dart';
import 'package:chess_app/src/features/home_page/presentation/widgets/search_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "lib/src/assets/images/background_image.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const _HomePageBody(),
      ],
    );
  }
}

class _HomePageBody extends StatefulWidget {
  const _HomePageBody();

  @override
  State<_HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<_HomePageBody> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomePageCubit(ChessGameRepository(ChessGameDataSource())),
      child: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          final chessGamesModels = state.listOfChessGamesModels;
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: const MyAppBar(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SearchTextField(
                      textEditingController: _textEditingController),
                  ChessGamesList(chessGamesModels: chessGamesModels),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
