import 'package:chess_app/src/app_theme/app_theme.dart';
import 'package:chess_app/src/common_widgets/menu_drawer.dart';
import 'package:chess_app/src/core/enums.dart';
import 'package:chess_app/src/core/injection_container.dart';
import 'package:chess_app/src/features/favourites/cubit/favourites_cubit.dart';
import 'package:chess_app/src/features/favourites/widgets/favourites__games_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FavouritesCubit>()..start(),
      child: BlocBuilder<FavouritesCubit, FavouritesState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppTheme.backgroundColor,
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Favourites'),
            ),
            body: _FavouritesPageBody(state: state),
            drawer: const MenuDrawer(),
            resizeToAvoidBottomInset: false,
          );
        },
      ),
    );
  }
}

class _FavouritesPageBody extends StatelessWidget {
  const _FavouritesPageBody({required this.state});

  final FavouritesState state;

  @override
  Widget build(BuildContext context) {
    final chessGameModels = state.listOfChessGamesModels;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Stack(
        children: [
          Center(
            child: Image.asset('lib/src/assets/images/logo5.png'),
          ),
          Builder(
            builder: (context) {
              switch (state.status) {
                case (Status.initial):
                  return const SizedBox.shrink();
                case (Status.loading):
                  return const Center(child: CircularProgressIndicator());
                case (Status.error):
                  return Center(child: Text(state.errorMessage.toString()));
                case (Status.success):
                  return FavouritesChessGamesList(
                      chessGamesModels: chessGameModels);
              }
            },
          )
        ],
      ),
    );
  }
}
