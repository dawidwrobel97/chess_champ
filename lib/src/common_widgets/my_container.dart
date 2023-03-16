import 'package:chess_app/src/app_theme/app_theme.dart';
import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({
    super.key,
    required this.child,
    required this.height,
    this.borderRadius,
  });

  final Widget child;
  final double height;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.fromLTRB(10, 7, 10, 12),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        boxShadow: AppTheme.containerShadows,
        border: Border.all(width: 2, color: AppTheme.borderColor),
        borderRadius: borderRadius,
        color: AppTheme.contanierColor,
      ),
      child: child,
    );
  }
}
