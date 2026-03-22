import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  const AppColors._();

  static const background = Color(0xFF080808);
  static const surface = Color(0xFF111111);
  static const surfaceLow = Color(0xFF151515);
  static const surfaceCard = Color(0xFF1A1A1A);
  static const surfaceRaised = Color(0xFF262626);
  static const surfaceHighest = Color(0xFF353534);
  static const inset = Color(0xFF000000);
  static const textPrimary = Color(0xFFE5E2E1);
  static const textMuted = Color(0xFFC9C4D8);
  static const accent = Color(0xFF7B61FF);
  static const accentDark = Color(0xFF24195B);
  static const success = Color(0xFF00FF41);
  static const alert = Color(0xFFFFB800);
  static const critical = Color(0xFFFF3B3B);
  static const ghost = Color(0x33484555);
  static const outlineVariant = Color(0xFF484555);
}

ThemeData buildFounderTheme() {
  final base = ThemeData.dark(useMaterial3: true);
  final textTheme = GoogleFonts.interTextTheme(base.textTheme).copyWith(
    headlineMedium: GoogleFonts.inter(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.4,
      color: AppColors.textPrimary,
    ),
    titleLarge: GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.2,
      color: AppColors.textPrimary,
    ),
    titleMedium: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.1,
      color: AppColors.textPrimary,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14,
      height: 1.5,
      color: AppColors.textPrimary,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 12,
      height: 1.4,
      color: AppColors.textMuted,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 11,
      letterSpacing: 1.1,
      fontWeight: FontWeight.w700,
      color: AppColors.textMuted,
    ),
  );

  final scheme = const ColorScheme.dark(
    surface: AppColors.surface,
    primary: AppColors.accent,
    secondary: AppColors.alert,
    error: AppColors.critical,
    onPrimary: AppColors.textPrimary,
    onSecondary: Color(0xFF2D2200),
    onSurface: AppColors.textPrimary,
  );

  return base.copyWith(
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: scheme,
    textTheme: textTheme,
    cardTheme: const CardThemeData(
      color: AppColors.surfaceCard,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background.withValues(alpha: 0.86),
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: textTheme.titleMedium,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.accent,
      unselectedItemColor: AppColors.textMuted,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),
    dividerColor: Colors.transparent,
    chipTheme: base.chipTheme.copyWith(
      backgroundColor: AppColors.surfaceRaised,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      side: BorderSide.none,
      labelStyle: textTheme.bodySmall,
      selectedColor: AppColors.accentDark,
      secondarySelectedColor: AppColors.accentDark,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inset,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppColors.ghost),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppColors.ghost),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppColors.accent),
      ),
      hintStyle: textTheme.bodySmall,
    ),
    sliderTheme: base.sliderTheme.copyWith(
      activeTrackColor: AppColors.accent,
      thumbColor: AppColors.accent,
      inactiveTrackColor: AppColors.surfaceRaised,
      overlayColor: AppColors.accent.withValues(alpha: 0.12),
    ),
  );
}
