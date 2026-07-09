import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../app/theme.dart';

/// Figma "Loading animation" sequence — one card, four stages:
/// sales link → clipboard → profile → social media prep.
const _stages = [
  'Generating your sales link..',
  'Copying the caption to clipboard',
  'Saving the content to your profile',
  'Preparing the content for social media',
];

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
  static const _stageMs = 1100;
  int _stage = 0;
  Timer? _timer;
  late final AnimationController _progress = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: _stageMs),
  )..forward();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: _stageMs), (t) {
      if (_stage >= _stages.length - 1) {
        t.cancel();
        Navigator.of(context).pop();
        return;
      }
      setState(() => _stage++);
      _progress.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
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
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Text(_stages[_stage],
                    key: ValueKey(_stage),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16, color: AppColors.greyText)),
              ),
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
