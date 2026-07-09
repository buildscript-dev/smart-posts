import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../app/theme.dart';

/// "Generating your sales link.." — white card over a blurred screen,
/// Oriflame spinner mark + animated progress bar. Auto-dismisses.
Future<void> showGeneratingLinkDialog(BuildContext context) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black26,
    pageBuilder: (_, _, _) => const Material(
        type: MaterialType.transparency, child: _GeneratingLinkDialog()),
  );
}

class _GeneratingLinkDialog extends StatefulWidget {
  const _GeneratingLinkDialog();

  @override
  State<_GeneratingLinkDialog> createState() => _GeneratingLinkDialogState();
}

class _GeneratingLinkDialogState extends State<_GeneratingLinkDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _progress = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2200),
  )..forward();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 2400), () {
      if (mounted) Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    _progress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 34),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Oriflame swirl mark, approximated with a ring on mint circle.
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: AppColors.brandGreenLight,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                        strokeWidth: 4, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              const Text('Generating your sales link..',
                  style: TextStyle(fontSize: 17, color: AppColors.greyText)),
              const SizedBox(height: 18),
              AnimatedBuilder(
                animation: _progress,
                builder: (_, _) => ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: _progress.value,
                    minHeight: 9,
                    backgroundColor: AppColors.trackGrey,
                    color: AppColors.brandGreenLight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
