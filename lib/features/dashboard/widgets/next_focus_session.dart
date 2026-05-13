import 'package:flutter/material.dart';
import '../dashboard_theme.dart';
import 'glass_card.dart';

class NextFocusSession extends StatelessWidget {
  const NextFocusSession({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Next Focus Session',
            style: TextStyle(
              color: DashboardTheme.onSurface,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              fontFamily: 'Sora',
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.event, color: DashboardTheme.secondary, size: 20),
              const SizedBox(width: 8),
              const Text(
                'DSA Practice • 7:00 PM',
                style: TextStyle(
                  color: DashboardTheme.secondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'JetBrains Mono',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style:
                  ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.transparent,
                    foregroundColor: DashboardTheme.onPrimaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ).copyWith(
                    backgroundColor: WidgetStateProperty.all(
                      Colors.transparent,
                    ),
                    overlayColor: WidgetStateProperty.all(
                      DashboardTheme.primary.withValues(alpha: 0.1),
                    ),
                  ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: DashboardTheme.containerGradient,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: DashboardTheme.primary.withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: const Center(
                  child: Text(
                    'Start Focus Session',
                    style: TextStyle(
                      color: DashboardTheme.onPrimaryContainer,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Sora',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
