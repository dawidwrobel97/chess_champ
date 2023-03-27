import 'package:chess_app/src/features/home_page/data/data_sources/chess_game_data_source.dart';
import 'package:chess_app/src/features/home_page/data/repositories/user_chess_games_repository.dart';
import 'package:chess_app/src/features/home_page/presentation/cubits/home_page_cubit/home_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class HomePageAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomePageAppBar({super.key, required this.name});

  final String? name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomePageCubit(UserChessGamesRepository(ChessGameDataSource())),
      child: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          if (name == null) {
            return AppBar();
          }
          return AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(name!),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    context.read<HomePageCubit>().dropDownMenu();
                  },
                  child: Icon(
                    state.dropDownMenuIsActive == false
                        ? Icons.arrow_drop_down_sharp
                        : Icons.arrow_drop_up_sharp,
                  ),
                ),
                const SizedBox(
                  width: 50,
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
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
