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
    return BlocProvider(
      create: (context) => ChessGameCubit()..start(widget.chessGameModel),
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
                        tag: widget.chessGameModel.gameId,
                        child: ch.ChessBoard(
                          onMove: () {
                            context.read<ChessGameCubit>().madeMove(widget
                                .chessGameModel.moveOnWhichMistakeHappened);
                          },
                          controller: state.chessBoardController!,
                          boardOrientation: widget.chessGameModel.userId ==
                                  widget.chessGameModel.whitePlayer
                              ? ch.PlayerColor.white
                              : ch.PlayerColor.black,
                          arrows: [
                            ch.BoardArrow(
                              from: state.wrongMove!.move.fromAlgebraic
                                  .toString(),
                              to: state.wrongMove!.move.toAlgebraic.toString(),
                              color: Colors.red.withOpacity(0.8),
                            )
                          ],
                        ),
                      ),
                      for (var i = 0; i < 8; i++)
                        BottomSquareAnnotation(
                          squareName: squareNames[i],
                          squareNumber: i,
                        ),
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

class BottomSquareAnnotation extends StatelessWidget {
  const BottomSquareAnnotation({
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
