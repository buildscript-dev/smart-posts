import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Floating bottom nav: rocket · search · home · chat · profile.
/// White outline icons over the post photo (dark ones on light screens).
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, this.color = Colors.white, this.onTap});

  final Color color;
  final void Function(int index)? onTap;

  static const icons = [
    Icons.rocket_launch_outlined,
    Icons.search,
    Icons.home_outlined,
    Icons.chat_bubble_outline,
    Icons.account_circle_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 8, 28, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var i = 0; i < icons.length; i++)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onTap == null
                      ? null
                      : () {
                          HapticFeedback.selectionClick();
                          onTap!(i);
                        },
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Icon(icons[i], color: color, size: 30),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
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
