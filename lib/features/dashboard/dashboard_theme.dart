import 'package:flutter/material.dart';

class DashboardTheme {
  // Colors from Tailwind config
  static const Color background = Color(0xFF131314);
  static const Color primary = Color(0xFFd0bcff);
  static const Color secondary = Color(0xFF89ceff);
  static const Color surface = Color(0xFF131314);
  static const Color onSurface = Color(0xFFe5e2e3);
  static const Color onSurfaceVariant = Color(0xFFcbc3d7);
  static const Color outline = Color(0xFF958ea0);
  static const Color surfaceContainerHighest = Color(0xFF353436);
  static const Color surfaceContainerLowest = Color(0xFF0e0e0f);
  static const Color primaryContainer = Color(0xFFa078ff);
  static const Color secondaryContainer = Color(0xFF00a2e6);
  static const Color onPrimaryContainer = Color(0xFF340080);

  // Glass card colors
  static const Color glassBackground = Color(
    0x08FFFFFF,
  ); // rgba(255, 255, 255, 0.03)
  static const Color glassBorder = Color(
    0x1AFFFFFF,
  ); // rgba(255, 255, 255, 0.1)

  // Gradient colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient containerGradient = LinearGradient(
    colors: [primaryContainer, secondaryContainer],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
