import 'package:flutter/material.dart';

/// Floating bottom nav: rocket · search · home · chat · profile.
/// White outline icons over the post photo (dark ones on light screens).
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, this.color = Colors.white});

  final Color color;

  @override
  Widget build(BuildContext context) {
    const icons = [
      Icons.rocket_launch_outlined,
      Icons.search,
      Icons.home_outlined,
      Icons.chat_bubble_outline,
      Icons.account_circle_outlined,
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 8, 28, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final icon in icons) Icon(icon, color: color, size: 30),
            ],
          ),
          const SizedBox(height: 10),
          // iOS home indicator bar, as drawn in the frames.
          Container(
            width: 130,
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ],
      ),
    );
  }
}
