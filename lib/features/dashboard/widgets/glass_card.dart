import 'package:flutter/material.dart';
import '../dashboard_theme.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final bool hasLeftBorder;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.hasLeftBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: DashboardTheme.glassBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: DashboardTheme.glassBorder, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
