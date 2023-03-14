import 'package:chess_app/src/app_theme/app_theme.dart';
import 'package:chess_app/src/common_widgets/app_bar.dart';
import 'package:chess_app/src/features/home_page/presentation/cubits/chess_game_cubit/chess_game_cubit.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:chess_app/src/features/home_page/presentation/widgets/bottom_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chess_app/src/features/home_page/presentation/widgets/chess_games_annotations/chess_game_annotations.dart';
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
              children: [
                _UpperBox(state: state, game: game),
                _ChessGameBoard(state: state, game: game),
                BottomContainer(state: state, game: game),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _UpperBox extends StatelessWidget {
  const _UpperBox({
    required this.state,
    required this.game,
  });
  final ChessGameState state;
  final ChessGameModel game;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Text(
              'Game between',
              style: GoogleFonts.oswald(
                textStyle: TextStyle(
                  fontSize: 17,
                  color: AppTheme.fontColor,
                ),
              ),
            ),
            Text(
              '${game.whitePlayer} and ${game.blackPlayer}',
              style: GoogleFonts.oswald(
                textStyle: TextStyle(
                  color: AppTheme.fontColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChessGameBoard extends StatelessWidget {
  _ChessGameBoard({
    required this.state,
    required this.game,
  });

  final ChessGameState state;
  final ChessGameModel game;
  final List<String> squareNames = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: game.gameId,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppTheme.shadowColor,
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
                  offset: const Offset(3, 3),
                ),
              ],
            ),
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
                        from: state.wrongMove!.move.fromAlgebraic.toString(),
                        to: state.wrongMove!.move.toAlgebraic.toString(),
                        color: Colors.red.withOpacity(0.8),
                      ),
                    ]
                  : [
                      ch.BoardArrow(
                        from: game.bestMove[0],
                        to: game.bestMove[1],
                        color: Colors.green.withOpacity(0.8),
                      ),
                    ],
            ),
          ),
        ),
        if (game.userId == game.whitePlayer)
          ..._buildWhiteAnnotations(squareNames),
        if (game.userId == game.blackPlayer)
          ..._buildBlackAnnotations(squareNames),
      ],
    );
  }
}

// The chess board widget doesn't have annotations (the numbers and letters on the edges of the board)
// so I made them myslef
List<Widget> _buildWhiteAnnotations(List<String> squareNames) {
  return [
    for (var i = 0; i < 8; i++)
      WhiteBottomSquareAnnotation(
        squareName: squareNames[i],
        squareNumber: i,
      ),
    for (var i = 0; i < 8; i++) WhiteSideSquareAnnotation(squareNumber: i),
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
