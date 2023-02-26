import 'package:chess_app/src/features/home_page/data/data_sources/chess_game_data_source.dart';
import 'package:chess_app/src/features/home_page/data/repositories/chess_game_repository.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:chess_app/src/features/home_page/presentation/cubits/cubit/home_page_cubit.dart';
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
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _SearchTextField(
                    textEditingController: _textEditingController,
                  ),
                  _GridviewBuilder(chessGamesModels: chessGamesModels),
                  Text(
                    _textEditingController.text,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SearchTextField extends StatelessWidget {
  const _SearchTextField({
    required this.textEditingController,
  });

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: const Color(0xFFDDDBDB),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context
                  .read<HomePageCubit>()
                  .getUserChessGamesFromId(textEditingController.text);
            },
            child: const Text(
              'Search',
            ),
          ),
        ],
      ),
    );
  }
}

class _GridviewBuilder extends StatelessWidget {
  const _GridviewBuilder({required this.chessGamesModels});

  final List<ChessGameModel>? chessGamesModels;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: chessGamesModels?.length ?? 0,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: Column(
                children: [
                  Text(chessGamesModels![index].id),
                  Text(chessGamesModels![index].rated.toString()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
