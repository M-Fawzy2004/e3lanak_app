import 'package:flutter/material.dart';

/// Single source of truth for all application color tokens.
/// Strictly adheres to zero raw Color literals outside this class.
abstract final class AppColors {
  // Brand Core Palette - Royal Blue & Vibrant Commercial Gold
  /// Primary: Vibrant Royal Blue
  static const Color primary = Color(0xFF0D5EF4);

  /// Primary Dark / Gradient Start
  static const Color primaryDark = Color(0xFF0946C2);

  /// Primary Light / Tint
  static const Color primaryLight = Color(0xFF4384F7);

  /// Primary Surface / Muted Container
  static const Color primarySurface = Color(0xFFEBF2FE);
  static const Color primaryContainer = Color(0xFFE0ECFF);

  // Secondary & Accent - Energetic Commercial Yellow / Gold
  /// Secondary / Accent: High-conversion actions
  static const Color secondary = Color(0xFFFFB800);
  static const Color accent = Color(0xFFFFB800);
  static const Color accentLight = Color(0xFFFFC933);
  static const Color accentDark = Color(0xFFE0A200);
  static const Color accentSurface = Color(0xFFFFF8E6);

  // High-Emphasis Dark Neutral & Text Tokens
  /// Dark Neutral / Deep Slate Black for high-emphasis text and dark elements
  static const Color darkNeutral = Color(0xFF0F172A);
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);

  // Background & Surface
  static const Color background = Colors.white;
  static const Color feedBackground = Color.fromARGB(255, 243, 243, 243);
  static const Color surface = Colors.white;
  static const Color border = Color(0xFFE2E8F0);
  static const Color divider = Color(0xFFE2E8F0);

  // Slate Neutral Scale
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);

  // Dark Mode Surfaces
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkCard = Color(0xFF1E293B);
  static const Color darkCardElevated = Color(0xFF273549);
  static const Color darkBorder = Color(0xFF334155);

  // Functional & Semantic Colors
  static const Color error = Color(0xFFEF4444);
  static const Color errorSurface = Color(0xFFFEE2E2);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningSurface = Color(0xFFFEF3C7);
  static const Color success = Color(0xFF10B981);
  static const Color info = Color(0xFF0D5EF4);

  // Splash Screen
  static const Color splashGradientTop = Color(0xFF0D5EF4);
  static const Color splashGradientBottom = Color(0xFF063399);

  // Pure & Alpha Overlays
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Colors.transparent;
  static const Color shimmerBase = Color(0xFFE2E8F0);
  static const Color shimmerHighlight = Color(0xFFF8FAFC);
  static const Color darkShimmerBase = Color(0xFF1E293B);
  static const Color darkShimmerHighlight = Color(0xFF334155);

  // Brand Gradients
  /// Primary Royal Blue Gradient (Start: #0946C2, End: #0D5EF4)
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0946C2), Color(0xFF0D5EF4)],
  );

  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [splashGradientTop, splashGradientBottom],
  );

  /// Alias for primary Royal Blue gradient
  static const LinearGradient royalBlueGradient = primaryGradient;

  /// High-Conversion Commercial Yellow / Gold Gradient
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFB800), Color(0xFFFFA500)],
  );

  /// Dark Mode Card Gradient
  static const LinearGradient darkCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
  );
}
