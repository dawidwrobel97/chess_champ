import 'package:flutter/material.dart';

class WhiteBottomSquareAnnotation extends StatelessWidget {
  const WhiteBottomSquareAnnotation({
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

class WhiteSideSquareAnnotation extends StatelessWidget {
  const WhiteSideSquareAnnotation({
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
