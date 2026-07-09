import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app/theme.dart';
import '../../data/mock_posts.dart';
import '../../data/models.dart';

/// Edit Caption page (02 Quick share frames): X · title · Save.
/// Designer notes honored: opens WITHOUT keyboard; tapping the caption
/// focuses it and opens the keyboard; Save enables only once text changes.
class EditCaptionPage extends StatefulWidget {
  const EditCaptionPage({super.key, required this.post});

  final SmartPost post;

  @override
  State<EditCaptionPage> createState() => _EditCaptionPageState();
}

class _EditCaptionPageState extends State<EditCaptionPage> {
  late final TextEditingController _controller;
  late final String _original;
  bool _dirty = false;

  @override
  void initState() {
    super.initState();
    _original = '${widget.post.caption}\n\n'
        'Use my referral code: $referralCode\n'
        'Use my referral link: $referralLink';
    _controller = TextEditingController(text: _original)
      ..addListener(() {
        final dirty = _controller.text != _original;
        if (dirty != _dirty) setState(() => _dirty = dirty);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.ink),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Expanded(
                    child: Text('Edit Caption',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.ink)),
                  ),
                  FilledButton(
                    onPressed: _dirty
                        ? () {
                            HapticFeedback.mediumImpact();
                            Navigator.of(context).pop();
                          }
                        : null,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.brandGreen,
                      disabledBackgroundColor: AppColors.brandGreenLight
                          .withValues(alpha: 0.45),
                      disabledForegroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                    ),
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: null,
                expands: true,
                // No autofocus: keyboard appears on caption tap (2nd click),
                // matching the annotated Figma flow.
                style: const TextStyle(
                    fontSize: 15, height: 1.45, color: AppColors.ink),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
