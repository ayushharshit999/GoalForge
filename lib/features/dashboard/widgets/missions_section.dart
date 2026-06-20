import 'package:flutter/material.dart';
import '../dashboard_theme.dart';
import 'glass_card.dart';

class MissionsSection extends StatelessWidget {
  const MissionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "TODAY'S MISSIONS",
              style: const TextStyle(
                color: DashboardTheme.onSurface,
                fontSize: 24,
                fontWeight: FontWeight.w600,
                fontFamily: 'Sora',
                letterSpacing: -0.01,
              ),
            ),
            Text(
              '3 TASKS REMAINING',
              style: const TextStyle(
                color: DashboardTheme.outline,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'JetBrains Mono',
                letterSpacing: 0.05,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            _buildMissionItem('Complete ML lecture'),
            const SizedBox(height: 16),
            _buildMissionItem('Gym workout'),
            const SizedBox(height: 16),
            _buildMissionItem('Solve 20 questions'),
          ],
        ),
      ],
    );
  }

  Widget _buildMissionItem(String title) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: DashboardTheme.outline, width: 2),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  color: DashboardTheme.onSurface,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Sora',
                  height: 1.3,
                ),
              ),
            ],
          ),
          Icon(Icons.more_vert, color: DashboardTheme.outline, size: 24),
        ],
      ),
    );
  }
}
