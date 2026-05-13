import 'package:flutter/material.dart';
import '../dashboard_theme.dart';

class DecorativeProgressVisual extends StatelessWidget {
  const DecorativeProgressVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 192,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: DashboardTheme.surfaceContainerHighest.withValues(alpha: 0.3),
      ),
      child: Stack(
        children: [
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  DashboardTheme.background,
                  DashboardTheme.background,
                ],
              ),
            ),
          ),
          // Content
          Positioned(
            left: 24,
            bottom: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PEAK PERFORMANCE MODE',
                  style: TextStyle(
                    color: DashboardTheme.secondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'JetBrains Mono',
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Deep Work Detected',
                  style: TextStyle(
                    color: DashboardTheme.onSurface,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Sora',
                    letterSpacing: -0.01,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
