import 'package:chess_app/src/common_widgets/my_container.dart';
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
    return MyContainer(
      height: MediaQuery.of(context).size.height * 0.3,
      borderRadius: const BorderRadius.all(
        Radius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          UpperText(game: game, state: state),
          UpperRow(state: state, game: game),
          MiddleText(state: state, game: game),
          SolutionButton(state: state, game: game),
        ],
      ),
    );
  }
}
