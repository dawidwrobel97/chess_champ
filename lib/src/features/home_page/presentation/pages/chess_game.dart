import 'package:chess_app/src/app_theme/app_theme.dart';
import 'package:chess_app/src/common_widgets/app_bar.dart';
import 'package:chess_app/src/features/home_page/presentation/cubits/chess_game_cubit/chess_game_cubit.dart';
import 'package:chess_app/src/features/home_page/domain/models/chess_game_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

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
    return BlocProvider(
      create: (context) => ChessGameCubit()..start(widget.chessGameModel),
      child: BlocBuilder<ChessGameCubit, ChessGameState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const MyAppBar(),
            body: Container(
              color: AppTheme.backgroundColor,
              height: double.infinity,
              width: double.infinity,
              child: Expanded(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 10,
                              child: Hero(
                                tag: widget.chessGameModel.gameId,
                                child: ChessBoard(
                                  controller: state.chessBoardController!,
                                  boardOrientation:
                                      widget.chessGameModel.userId ==
                                              widget.chessGameModel.whitePlayer
                                          ? PlayerColor.white
                                          : PlayerColor.black,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  height: 10,
                                  width:
                                      (MediaQuery.of(context).size.width - 10) /
                                          8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  height: 10,
                                  width:
                                      (MediaQuery.of(context).size.width - 10) /
                                          8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  height: 10,
                                  width:
                                      (MediaQuery.of(context).size.width - 10) /
                                          8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  height: 10,
                                  width:
                                      (MediaQuery.of(context).size.width - 10) /
                                          8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  height: 10,
                                  width:
                                      (MediaQuery.of(context).size.width - 10) /
                                          8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  height: 10,
                                  width:
                                      (MediaQuery.of(context).size.width - 10) /
                                          8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  height: 10,
                                  width:
                                      (MediaQuery.of(context).size.width - 10) /
                                          8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  height: 10,
                                  width:
                                      (MediaQuery.of(context).size.width - 10) /
                                          8,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            width: 10,
                            height: MediaQuery.of(context).size.width - 10)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
