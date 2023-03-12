import 'package:chess_app/src/app_theme/app_theme.dart';
import 'package:chess_app/src/common_widgets/app_bar.dart';
import 'package:chess_app/src/features/home_page/presentation/cubits/chess_game_cubit/chess_game_cubit.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart' as ch;

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
  List<String> squareNames = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];

  @override
  Widget build(BuildContext context) {
    final game = widget.chessGameModel;

    return BlocProvider(
      create: (context) => ChessGameCubit()..start(game),
      child: BlocBuilder<ChessGameCubit, ChessGameState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const MyAppBar(),
            body: Container(
              color: AppTheme.backgroundColor,
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Stack(
                    children: [
                      Hero(
                        tag: game.gameId,
                        child: ch.ChessBoard(
                          enableUserMoves: state.enabledMoves,
                          onMove: () {
                            context
                                .read<ChessGameCubit>()
                                .madeMove(game.moveOnWhichMistakeHappened);
                          },
                          controller: state.chessBoardController!,
                          boardOrientation: game.userId == game.whitePlayer
                              ? ch.PlayerColor.white
                              : ch.PlayerColor.black,
                          arrows: state.enabledMoves == true
                              ? [
                                  ch.BoardArrow(
                                    from: state.wrongMove!.move.fromAlgebraic
                                        .toString(),
                                    to: state.wrongMove!.move.toAlgebraic
                                        .toString(),
                                    color: Colors.red.withOpacity(0.8),
                                  ),
                                ]
                              : [],
                        ),
                      ),
                      if (game.userId == game.whitePlayer)
                        ..._buildWhiteAnnotations(squareNames),
                      if (game.userId == game.blackPlayer)
                        ..._buildBlackAnnotations(squareNames),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

List<Widget> _buildWhiteAnnotations(List<String> squareNames) {
  return [
    for (var i = 0; i < 8; i++)
      _WhiteBottomSquareAnnotation(
        squareName: squareNames[i],
        squareNumber: i,
      ),
    for (var i = 0; i < 8; i++) _WhiteSideSquareAnnotation(squareNumber: i),
  ];
}

List<Widget> _buildBlackAnnotations(List<String> squareNames) {
  return [
    for (var i = 0; i < 8; i++)
      BlackBottomSquareAnnotation(
        squareName: squareNames.reversed.toList()[i],
        squareNumber: i,
      ),
    for (var i = 0; i < 8; i++) BlackSideSquareAnnotation(squareNumber: i),
  ];
}

class _WhiteBottomSquareAnnotation extends StatelessWidget {
  const _WhiteBottomSquareAnnotation({
    required this.squareName,
    required this.squareNumber,
  });

  final String squareName;
  final int squareNumber;

  @override
  Widget build(BuildContext context) {
    const int outlineOffset = 5;
    const int margin = 3;
    final double sizeOfASingleSquare =
        (MediaQuery.of(context).size.width - outlineOffset) / 8;
    return Positioned(
      bottom: 2,
      left: sizeOfASingleSquare -
          (sizeOfASingleSquare - margin) +
          squareNumber * sizeOfASingleSquare,
      child: Text(
        squareName,
        style: TextStyle(
            color: squareNumber % 2 == 0
                ? const Color(0xFFf0d9b5)
                : const Color(0xFFb58863)),
      ),
    );
  }
}

class BlackBottomSquareAnnotation extends StatelessWidget {
  const BlackBottomSquareAnnotation({
    super.key,
    required this.squareName,
    required this.squareNumber,
  });

  final String squareName;
  final int squareNumber;

  @override
  Widget build(BuildContext context) {
    const int outlineOffset = 5;
    const int margin = 3;
    final double sizeOfASingleSquare =
        (MediaQuery.of(context).size.width - outlineOffset) / 8;
    return Positioned(
      bottom: 2,
      left: sizeOfASingleSquare -
          (sizeOfASingleSquare - margin) +
          squareNumber * sizeOfASingleSquare,
      child: Text(
        squareName,
        style: TextStyle(
            color: squareNumber % 2 == 0
                ? const Color(0xFFf0d9b5)
                : const Color(0xFFb58863)),
      ),
    );
  }
}

class _WhiteSideSquareAnnotation extends StatelessWidget {
  const _WhiteSideSquareAnnotation({
    required this.squareNumber,
  });

  final int squareNumber;

  @override
  Widget build(BuildContext context) {
    const int outlineOffset = 5;
    const int margin = 3;
    final double sizeOfASingleSquare =
        (MediaQuery.of(context).size.width - outlineOffset) / 8;
    return Positioned(
      right: 2,
      top: sizeOfASingleSquare -
          (sizeOfASingleSquare - margin) +
          squareNumber * sizeOfASingleSquare,
      child: Text(
        (8 - squareNumber).toString(),
        style: TextStyle(
            color: squareNumber % 2 == 0
                ? const Color(0xFFf0d9b5)
                : const Color(0xFFb58863)),
      ),
    );
  }
}

class BlackSideSquareAnnotation extends StatelessWidget {
  const BlackSideSquareAnnotation({
    super.key,
    required this.squareNumber,
  });

  final int squareNumber;

  @override
  Widget build(BuildContext context) {
    const int outlineOffset = 5;
    const int margin = 3;
    final double sizeOfASingleSquare =
        (MediaQuery.of(context).size.width - outlineOffset) / 8;
    return Positioned(
      right: 2,
      top: sizeOfASingleSquare -
          (sizeOfASingleSquare - margin) +
          squareNumber * sizeOfASingleSquare,
      child: Text(
        (squareNumber + 1).toString(),
        style: TextStyle(
            color: squareNumber % 2 == 0
                ? const Color(0xFFf0d9b5)
                : const Color(0xFFb58863)),
      ),
    );
  }
}
