import 'package:flutter/material.dart';

import 'app/theme.dart';
import 'features/loading/building_posts_screen.dart';

void main() => runApp(const BrandieSmartPostsApp());

class BrandieSmartPostsApp extends StatelessWidget {
  const BrandieSmartPostsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oriflame Smart Posts',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const BuildingPostsScreen(),
    );
  }
}
