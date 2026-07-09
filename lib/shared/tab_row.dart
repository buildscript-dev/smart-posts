import 'package:flutter/material.dart';

import '../app/theme.dart';

const _tabs = ['Smart Post', 'Library', 'Communities', 'Share&Win'];

/// Top tab row. "Smart Post" is active (green) on every design frame.
class SmartTabRow extends StatelessWidget {
  const SmartTabRow({super.key, this.activeIndex = 0});

  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var i = 0; i < _tabs.length; i++)
            Text(
              _tabs[i],
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w600,
                color: i == activeIndex
                    ? AppColors.brandGreen
                    : Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : AppColors.ink,
              ),
            ),
        ],
      ),
    );
  }
}
