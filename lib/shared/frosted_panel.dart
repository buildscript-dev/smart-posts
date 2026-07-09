import 'dart:ui';

import 'package:flutter/material.dart';

import '../app/theme.dart';

/// Reused translucent blur panel behind music row / caption / product card.
class FrostedPanel extends StatelessWidget {
  const FrostedPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(12),
    this.radius = 10,
    this.color = AppColors.scrim,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(padding: padding, color: color, child: child),
      ),
    );
  }
}
