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
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.chessModel?[1].id ?? 'No data',
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<HomePageCubit>()
                          .getChessGameFromId('J9iArtcQ');
                    },
                    child: const Text(
                      'Press for data',
                    ),
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
