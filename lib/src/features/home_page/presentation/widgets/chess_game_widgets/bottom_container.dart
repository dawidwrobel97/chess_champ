import 'package:chess_app/src/app_theme/app_theme.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:chess_app/src/features/home_page/presentation/cubits/chess_game_cubit/chess_game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _UpperText(game: game, state: state),
        _UpperRow(state: state, game: game),
        _MiddleText(state: state, game: game),
        _SolutionButton(state: state, game: game),
      ],
    );
  }
}

class _UpperText extends StatelessWidget {
  const _UpperText({
    required this.game,
    required this.state,
  });

  final ChessGameModel game;
  final ChessGameState state;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (state.madeTheBestMove == false) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'Your biggest mistake in game was on move ${(game.moveOnWhichMistakeHappened / 2).round()}\n when you played ${game.worstMove}',
                  style: GoogleFonts.oswald(
                      textStyle: const TextStyle(fontSize: 20)),
                  textAlign: TextAlign.center,
                ),
              ),
              _MyDivider(state: state)
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _MyDivider extends StatelessWidget {
  const _MyDivider({
    required this.state,
  });

  final ChessGameState state;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (state.madeTheBestMove == false) {
          return Divider(
            thickness: 1.5,
            color: AppTheme.borderColor,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _UpperRow extends StatelessWidget {
  const _UpperRow({
    required this.state,
    required this.game,
  });

  final ChessGameState state;
  final ChessGameModel game;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (state.madeTheBestMove == false) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Text(
                  'That move cost you ${game.biggestScoreDifference} points of material',
                  textAlign: TextAlign.center,
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Flexible(
                      child: Text(
                          'For comparison, 3 points of material equals a knight!'),
                    ),
                    Placeholder(
                      fallbackHeight: 50,
                      fallbackWidth: 50,
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}

class _MiddleText extends StatelessWidget {
  const _MiddleText({
    required this.state,
    required this.game,
  });

  final ChessGameState state;
  final ChessGameModel game;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (state.madeTheSameMistake == true) {
          return const Text(
            'Oops! That\'s the mistake you did! Try again! :)',
            style: TextStyle(
              fontSize: 18,
            ),
          );
        } else if (state.madeWrongMove == true) {
          return const Text(
            'That\'s not it... Try again!',
            style: TextStyle(
              fontSize: 18,
            ),
          );
        } else if (state.pressedButtonForSolution == true) {
          return Text(
            'The best move was ${game.bestMove[0]} to ${game.bestMove[1]}. Try again!',
            style: const TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          );
        } else if (state.madeTheBestMove == true) {
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Icon(
                  Icons.celebration,
                  size: 50,
                ),
              ),
              Text(
                'Yes!!! That\'s it! The best move was moving the piece from ${game.bestMove[0]} to ${game.bestMove[1]}!\nI can already see you becoming better! ;)',
                style: const TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
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
        return const Text(
          'Can you find the best move instead?',
          style: TextStyle(
            fontSize: 16,
          ),
        );
      },
    );
  }
}

class _SolutionButton extends StatelessWidget {
  const _SolutionButton({
    required this.state,
    required this.game,
  });

  final ChessGameState state;
  final ChessGameModel game;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (state.madeTheBestMove == false &&
            state.pressedButtonForSolution == false) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: ElevatedButton(
              onPressed: () {
                context.read<ChessGameCubit>().makeTheBestMove(game);
              },
              child: const Text(
                'I give up! Show me the best move!',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          );
        } else if (state.pressedButtonForSolution == true) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Go back',
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
