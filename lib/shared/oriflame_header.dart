import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app/theme.dart';

/// Brand header: AI assistant chip · ORIFLAME logo · camera button.
class OriflameHeader extends StatelessWidget {
  const OriflameHeader({
    super.key,
    this.showAssistant = true,
    this.onAssistantTap,
    this.onCameraTap,
  });

  final bool showAssistant;
  final VoidCallback? onAssistantTap;
  final VoidCallback? onCameraTap;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 64,
            child: showAssistant
                ? _AssistantChip(onTap: onAssistantTap)
                : null,
          ),
          Expanded(
            child: Center(
              child: Image.asset(
                dark
                    ? 'assets/images/oriflame_logo_white.png'
                    : 'assets/images/oriflame_logo.png',
                height: 34,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            width: 64,
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: onCameraTap == null
                    ? null
                    : () {
                        HapticFeedback.lightImpact();
                        onCameraTap!();
                      },
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
          ),
        ],
      ),
    );
  }
}

/// Charcoal disc, white ring nudged bottom-left, thin swoosh arc top-left —
/// the Oriflame swirl mark from the design.
class _SwirlPainter extends CustomPainter {
  const _SwirlPainter({required this.disc});

  final Color disc;

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final onDisc = disc == Colors.white ? AppColors.darkBg : Colors.white;
    canvas.drawCircle(c, size.width / 2, Paint()..color = disc);
    // main ring, slightly off-center toward bottom-left
    final ring = Paint()
      ..color = onDisc
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.5;
    canvas.drawCircle(c + const Offset(-1.5, 2), size.width / 2 - 8.5, ring);
    // swoosh: thin arc floating at the top-left, outside the ring
    final swoosh = Paint()
      ..color = onDisc
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
        Rect.fromCircle(
            center: c + const Offset(-1.5, 2), radius: size.width / 2 - 3.5),
        3.55, // ~203°
        1.25, // ~72° sweep toward the top
        false,
        swoosh);
  }

  @override
  bool shouldRepaint(_SwirlPainter old) => old.disc != disc;
}

class _AssistantChip extends StatelessWidget {
  const _AssistantChip({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final ink = dark ? Colors.white : AppColors.ink;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap == null
          ? null
          : () {
              HapticFeedback.lightImpact();
              onTap!();
            },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 46,
            height: 42,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Filled charcoal disc with the Oriflame-style white swirl.
                CustomPaint(
                  size: const Size(40, 40),
                  painter: _SwirlPainter(disc: dark ? Colors.white : ink),
                ),
                Positioned(
                  top: -7,
                  right: -8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 7, vertical: 2.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF7CBF8C),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('AI',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Text('Your Assistant', style: TextStyle(fontSize: 9, color: ink)),
        ],
      ),
    );
  }
}
