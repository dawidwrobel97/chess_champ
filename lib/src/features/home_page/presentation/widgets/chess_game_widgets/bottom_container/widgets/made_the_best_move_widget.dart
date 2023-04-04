import 'package:chess_app/src/common_widgets/my_elevated_button.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:flutter/material.dart';

class MadeTheBestMoveWidget extends StatelessWidget {
  const MadeTheBestMoveWidget({
    super.key,
    required this.game,
  });

  final ChessGameModel game;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Icon(
            Icons.celebration_outlined,
            size: 50,
            color: Colors.white,
          ),
        ),
        Text(
          'Yes!!! That\'s it! The best move was moving the piece from ${game.bestMove![0]} to ${game.bestMove![1]}!\nI can already see you becoming better! ;)',
          style: const TextStyle(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: MyElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Go back',
            ),
          ),
        )
      ],
    );
  }
}
