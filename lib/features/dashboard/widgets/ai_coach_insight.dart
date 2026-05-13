import 'package:flutter/material.dart';
import '../dashboard_theme.dart';
import 'glass_card.dart';

class AiCoachInsight extends StatelessWidget {
  const AiCoachInsight({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      hasLeftBorder: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, color: DashboardTheme.primary, size: 24),
              const SizedBox(width: 12),
              const Text(
                'AI COACH INSIGHT',
                style: TextStyle(
                  color: DashboardTheme.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'JetBrains Mono',
                  letterSpacing: 0.1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            '"You usually lose momentum after 9PM. Consider moving your high-intensity focus sessions 60 minutes earlier to capitalize on your peak cognitive window."',
            style: TextStyle(
              color: DashboardTheme.onSurfaceVariant,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Geist',
              fontStyle: FontStyle.italic,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
