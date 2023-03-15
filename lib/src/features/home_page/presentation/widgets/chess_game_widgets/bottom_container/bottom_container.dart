import 'package:chess_app/src/app_theme/app_theme.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:chess_app/src/features/home_page/presentation/cubits/chess_game_cubit/chess_game_cubit.dart';
import 'package:chess_app/src/features/home_page/presentation/widgets/chess_game_widgets/bottom_container/widgets/middle_text.dart';
import 'package:chess_app/src/features/home_page/presentation/widgets/chess_game_widgets/bottom_container/widgets/solution_button.dart';
import 'package:chess_app/src/features/home_page/presentation/widgets/chess_game_widgets/bottom_container/widgets/upper_row.dart';
import 'package:chess_app/src/features/home_page/presentation/widgets/chess_game_widgets/bottom_container/widgets/upper_text.dart';
import 'package:flutter/material.dart';

class BottomContainer extends StatelessWidget {
  const BottomContainer({
    super.key,
    required this.state,
    required this.game,
  });

  final ChessGameState state;
  final ChessGameModel game;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      margin: const EdgeInsets.fromLTRB(10, 7, 10, 12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowColor,
            blurRadius: 4.0,
            spreadRadius: 1.0,
            offset: const Offset(3, 5),
          ),
          BoxShadow(
            color: AppTheme.shadowColor,
            blurRadius: 4.0,
            spreadRadius: 1.0,
            offset: const Offset(-3, 5),
          ),
        ],
        border: Border.all(width: 2, color: AppTheme.borderColor),
        borderRadius: const BorderRadius.all(
          Radius.circular(30),
        ),
        color: AppTheme.contanierColor,
      ),
      child: _EntireContainer(game: game, state: state),
    );
  }
}

class _EntireContainer extends StatelessWidget {
  const _EntireContainer({
    required this.game,
    required this.state,
  });

  final ChessGameModel game;
  final ChessGameState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        UpperText(game: game, state: state),
        UpperRow(state: state, game: game),
        MiddleText(state: state, game: game),
        SolutionButton(state: state, game: game),
      ],
    );
  }
}
