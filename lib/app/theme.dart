import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design tokens sampled pixel-exact from the Figma export frames.
abstract class AppColors {
  static const brandGreen = Color(0xFF73BF98); // active tab, page dots
  static const brandGreenLight = Color(0xFF9ED5AD); // camera btn, spinners
  static const deepGreen = Color(0xFF00725B); // "30% off" badge
  static const pillPink = Color(0xFFEB858C); // "Ready to share" gradient L
  static const pillPurple = Color(0xFFC9A6E0); // "Ready to share" gradient R
  static const ink = Color(0xFF212328); // headings (light mode)
  static const greyText = Color(0xFF595959); // inactive tabs
  static const greyMuted = Color(0xFFC5C7CB); // pending checklist steps
  static const trackGrey = Color(0xFFEEF2F0); // progress track
  static const darkBg = Color(0xFF090B0E); // dark loading screens
  static const cream = Color(0xFFF3E6D4); // product thumb card bg
  static const scrim = Colors.black38; // frosted overlay panels
}

ThemeData buildTheme() {
  final base = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.brandGreen,
      primary: AppColors.brandGreen,
    ),
  );
  // Jost: closest free match to the geometric single-story-'a' brand face.
  return base.copyWith(textTheme: GoogleFonts.jostTextTheme(base.textTheme));
}
