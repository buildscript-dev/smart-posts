import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../shared/bottom_nav.dart';
import '../../shared/oriflame_header.dart';
import 'assistant_screen.dart';
import 'camera_service.dart';
import 'chat_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';

/// Bottom-nav tab indices (0 = the Smart Post feed itself).
const tabFeed = 0, tabSearch = 1, tabHome = 2, tabChat = 3, tabProfile = 4;

Widget _screenFor(int index) => switch (index) {
      tabSearch => const SearchScreen(),
      tabHome => const HomeScreen(),
      tabChat => const ChatListScreen(),
      tabProfile => const ProfileScreen(),
      _ => const SizedBox.shrink(),
    };

/// Feed stays the root route. Icons push a shell page; switching between
/// shell pages replaces it, so back always returns to the feed.
void goTab(BuildContext context, int current, int target) {
  if (target == current) return;
  if (target == tabFeed) {
    Navigator.of(context).popUntil((r) => r.isFirst);
    return;
  }
  final route = MaterialPageRoute(builder: (_) => _screenFor(target));
  if (current == tabFeed) {
    Navigator.of(context).push(route);
  } else {
    Navigator.of(context).pushReplacement(route);
  }
}

void openAssistant(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (_) => const AssistantScreen()));
}

/// Shared scaffold for shell pages: brand header + body + working nav.
class ShellScaffold extends StatelessWidget {
  const ShellScaffold(
      {super.key, required this.index, required this.body, this.onCameraReturn});

  final int index;
  final Widget body;

  /// Called after the camera flow finishes (profile refreshes its gallery).
  final VoidCallback? onCameraReturn;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            OriflameHeader(
              onAssistantTap: () => openAssistant(context),
              onCameraTap: () async {
                await captureToGallery(context);
                onCameraReturn?.call();
              },
            ),
            Expanded(child: body),
            AppBottomNav(
              color: dark ? Colors.white : AppColors.ink,
              onTap: (i) => goTab(context, index, i),
            ),
          ],
        ),
      ),
    );
  }
}
