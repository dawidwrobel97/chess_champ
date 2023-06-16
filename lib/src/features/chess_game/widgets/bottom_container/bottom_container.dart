import 'package:chess_app/src/common_widgets/my_container.dart';
import 'package:chess_app/src/features/chess_game/cubit/chess_game_cubit.dart';
import 'package:chess_app/src/features/chess_game/widgets/chess_game_widgets/bottom_container/widgets/middle_text.dart';
import 'package:chess_app/src/features/chess_game/widgets/bottom_container/widgets/solution_button.dart';
import 'package:chess_app/src/features/chess_game/widgets/bottom_container/widgets/upper_row.dart';
import 'package:chess_app/src/features/chess_game/widgets/bottom_container/widgets/upper_text.dart';
import 'package:flutter/material.dart';

class BottomContainer extends StatelessWidget {
  const BottomContainer({
    super.key,
    required this.state,
  });

  final ChessGameState state;

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
          UpperText(state: state),
          UpperRow(state: state),
          MiddleText(state: state),
          SolutionButton(state: state),
        ],
      ),
    );
  }
}
