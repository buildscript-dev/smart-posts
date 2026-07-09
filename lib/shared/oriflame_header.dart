import 'package:flutter/material.dart';

import '../app/theme.dart';

/// Brand header: AI assistant chip · ORIFLAME logo · camera button.
class OriflameHeader extends StatelessWidget {
  const OriflameHeader({super.key, this.showAssistant = true});

  final bool showAssistant;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 64,
            child: showAssistant ? const _AssistantChip() : null,
          ),
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/images/oriflame_logo.png',
                height: 34,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            width: 64,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  color: AppColors.brandGreenLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.photo_camera_outlined,
                    color: Colors.white, size: 26),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AssistantChip extends StatelessWidget {
  const _AssistantChip();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.ink, width: 5),
              ),
            ),
            Positioned(
              top: -6,
              right: -10,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                  color: AppColors.brandGreenLight,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('AI',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        const Text('Your Assistant',
            style: TextStyle(fontSize: 9, color: AppColors.ink)),
      ],
    );
  }
}
