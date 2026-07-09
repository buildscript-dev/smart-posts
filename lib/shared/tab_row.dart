import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app/theme.dart';

const _tabs = ['Smart Post', 'Library', 'Communities', 'Share&Win'];

/// Top tab row. Active tab is brand green.
class SmartTabRow extends StatelessWidget {
  const SmartTabRow({super.key, this.activeIndex = 0, this.onTap});

  final int activeIndex;
  final void Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var i = 0; i < _tabs.length; i++)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTap == null
                  ? null
                  : () {
                      HapticFeedback.selectionClick();
                      onTap!(i);
                    },
              // generous hit area (~44px) around each label
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                child: Text(
                  _tabs[i],
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    color: i == activeIndex
                        ? AppColors.brandGreen
                        : dark
                            ? Colors.white
                            : AppColors.ink,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
