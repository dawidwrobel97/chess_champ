import 'package:chess_app/src/app_theme/app_theme.dart';
import 'package:chess_app/src/common_widgets/app_bar.dart';
import 'package:chess_app/src/features/home_page/presentation/cubits/chess_game_cubit/chess_game_cubit.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:chess_app/src/features/home_page/presentation/widgets/chess_game_widgets/bottom_container/bottom_container.dart';
import 'package:chess_app/src/features/home_page/presentation/widgets/chess_game_widgets/chess_game_board.dart';
import 'package:chess_app/src/features/home_page/presentation/widgets/chess_game_widgets/upper_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChessGame extends StatefulWidget {
  const ChessGame({
    super.key,
    required this.chessGameModel,
  });

  final ChessGameModel chessGameModel;

  @override
  State<ChessGame> createState() => _ChessGameState();
}

class _ChessGameState extends State<ChessGame> {
  @override
  Widget build(BuildContext context) {
    final game = widget.chessGameModel;

    return BlocProvider(
      create: (context) => ChessGameCubit()..start(game),
      child: BlocBuilder<ChessGameCubit, ChessGameState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const MyAppBar(),
            backgroundColor: AppTheme.backgroundColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UpperBox(state: state, game: game),
                ChessGameBoard(state: state, game: game),
                BottomContainer(state: state, game: game),
              ],
            ),
          );
        },
      ),
    );
  }
}
