import 'dart:async';

import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../shared/bottom_nav.dart';
import '../../shared/oriflame_header.dart';
import '../../shared/tab_row.dart';
import '../smart_post/smart_post_screen.dart';

const _steps = [
  'Preparing popular\ncontent for you',
  'Crafting a caption to\nboost engagement',
  'Adding your personal\nreferral link and code',
  'Finding trending songs on\nother social media',
];

/// "Building personalised Smart Posts for you!" — steps complete one by one,
/// then "All set!" shows and the feed opens. Long-press toggles dark mode
/// (both variants exist in the design's LOADING section).
class BuildingPostsScreen extends StatefulWidget {
  const BuildingPostsScreen({super.key});

  @override
  State<BuildingPostsScreen> createState() => _BuildingPostsScreenState();
}

class _BuildingPostsScreenState extends State<BuildingPostsScreen> {
  int _done = 0; // steps fully checked; _done == index → that step spins
  bool _dark = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 1100), (t) {
      setState(() => _done++);
      if (_done > _steps.length) {
        t.cancel();
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, _, _) => const SmartPostScreen(),
            transitionsBuilder: (_, anim, _, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: const Duration(milliseconds: 400),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ink = _dark ? Colors.white : AppColors.ink;
    final allDone = _done >= _steps.length;
    return Scaffold(
      backgroundColor: _dark ? AppColors.darkBg : Colors.white,
      body: GestureDetector(
        onLongPress: () => setState(() => _dark = !_dark),
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: Column(
            children: [
              if (!_dark) ...[
                const OriflameHeader(showAssistant: false),
                const SmartTabRow(),
              ],
              const Spacer(flex: 2),
              Text(
                'Building personalised\nSmart Posts for you!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 26, fontWeight: FontWeight.w600, color: ink),
              ),
              const SizedBox(height: 40),
              for (var i = 0; i < _steps.length; i++) ...[
                _StepRow(
                  label: _steps[i],
                  state: i < _done
                      ? _StepState.done
                      : i == _done
                          ? _StepState.active
                          : _StepState.pending,
                  dark: _dark,
                ),
                const SizedBox(height: 22),
              ],
              AnimatedOpacity(
                opacity: allDone ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                child: Text('All set! Get ready to share...',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: ink)),
              ),
              const Spacer(flex: 3),
              AppBottomNav(color: _dark ? Colors.white : AppColors.ink),
            ],
          ),
        ),
      ),
    );
  }
}

enum _StepState { pending, active, done }

class _StepRow extends StatelessWidget {
  const _StepRow({required this.label, required this.state, required this.dark});

  final String label;
  final _StepState state;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final active = state == _StepState.active;
    final done = state == _StepState.done;
    final textColor = done || active
        ? (dark ? Colors.white : AppColors.ink)
        : AppColors.greyMuted;

    Widget indicator;
    switch (state) {
      case _StepState.done:
        indicator = const Icon(Icons.check_circle,
            color: AppColors.brandGreenLight, size: 26);
      case _StepState.active:
        indicator = const SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
              strokeWidth: 3, color: AppColors.brandGreenLight),
        );
      case _StepState.pending:
        indicator = Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.greyMuted, width: 2.5),
          ),
        );
    }

    return SizedBox(
      width: 320,
      child: Row(
        children: [
          SizedBox(width: 40, child: Center(child: indicator)),
          const SizedBox(width: 14),
          Text(
            label,
            style: TextStyle(
              fontSize: 17,
              height: 1.25,
              color: textColor,
              fontWeight: active || done ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
