import 'package:chess_app/src/features/home_page/data/data_sources/chess_game_data_source.dart';
import 'package:chess_app/src/features/home_page/data/repositories/chess_game_repository.dart';
import 'package:chess_app/src/features/home_page/presentation/cubits/cubit/home_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomePageCubit(ChessGameRepository(ChessGameDataSource())),
      child: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
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
        },
      ),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [
            _SearchTextField(),
            _GridviewBuilder(),
          ],
        ),
      ),
    );
  }
}

class _SearchTextField extends StatelessWidget {
  const _SearchTextField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          FractionallySizedBox(
            widthFactor: 0.9,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFDDDBDB),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
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
  const _GridviewBuilder();

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
          // itemCount: state.chessModel?.length ?? 0,
          itemCount: 5,
          itemBuilder: (context, index) {
            return const Placeholder();
          },
        ),
      ),
    );
  }
}
