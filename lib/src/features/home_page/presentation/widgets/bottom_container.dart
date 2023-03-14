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
    return Expanded(
      child: Container(
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
      ),
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
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _UpperText(game: game, state: state),
            _MyDivider(state: state),
            _MainColumn(game: game, state: state),
          ],
        ),
      ),
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
          return Text(
            'Your biggest mistake in game was on move ${(game.moveOnWhichMistakeHappened / 2).round()}\n when you played ${game.worstMove}',
            style: GoogleFonts.oswald(textStyle: const TextStyle(fontSize: 20)),
            textAlign: TextAlign.center,
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

class _MainColumn extends StatelessWidget {
  const _MainColumn({
    required this.game,
    required this.state,
  });

  final ChessGameModel game;
  final ChessGameState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            _UpperRow(state: state, game: game),
            _MiddleText(state: state),
            _SolutionButton(state: state, game: game),
          ],
        ),
      ],
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
        return Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  'That move cost you ${game.biggestScoreDifference} points of material',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
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
              ),
            )
          ],
        );
      }
      return const SizedBox.shrink();
    });
  }
}

class _MiddleText extends StatelessWidget {
  const _MiddleText({
    required this.state,
  });

  final ChessGameState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 10, 4, 4),
      child: Builder(
        builder: (context) {
          if (state.madeTheSameMistake == false &&
              state.madeWrongMove == false &&
              state.madeTheBestMove == false) {
            return const Text(
              'Can you find the best move instead?',
              style: TextStyle(
                fontSize: 16,
              ),
            );
          } else if (state.madeTheSameMistake == true) {
            return const Flexible(
              child: Text(
                'Oops! That\'s the mistake you did! Try again! :)',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            );
          } else if (state.madeWrongMove == true) {
            return const Text(
              'That\'s not it... Try again!',
              style: TextStyle(
                fontSize: 16,
              ),
            );
          } else if (state.madeTheBestMove == true) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.celebration,
                    size: 50,
                  ),
                ),
                Text(
                  'Yes!!! That\'s it! Congratulations!\nI can already see you becoming better! ;)',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          }
          return const Text(
              'Uhmm...You aren\'t supposed to see this...akward...');
        },
      ),
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
        if (state.madeTheBestMove == false) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                context.read<ChessGameCubit>().makeTheBestMove(game);
              },
              child: const Text(
                'I give up! Show me the best move!',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
