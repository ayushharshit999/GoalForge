import 'package:flutter/material.dart';
import 'dashboard_theme.dart';
import 'widgets/glass_card.dart';
import 'widgets/weekly_progress_ring.dart';
import 'widgets/ai_coach_insight.dart';
import 'widgets/next_focus_session.dart';
import 'widgets/missions_section.dart';
import 'widgets/decorative_progress_visual.dart';

class DashboardHomePage extends StatelessWidget {
  const DashboardHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DashboardTheme.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 96, 24, 128),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGreeting(),
                const SizedBox(height: 16),
                _buildHeroSection(),
                const SizedBox(height: 80),
                const MissionsSection(),
                const SizedBox(height: 80),
                const DecorativeProgressVisual(),
              ],
            ),
          ),
          _buildTopAppBar(),
        ],
      ),
    );
  }

  Widget _buildTopAppBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: DashboardTheme.surface.withValues(alpha: 0.1),
          border: Border(
            bottom: BorderSide(color: DashboardTheme.glassBorder, width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.bolt, color: DashboardTheme.primary, size: 32),
                const SizedBox(width: 8),
                ShaderMask(
                  shaderCallback: (bounds) =>
                      DashboardTheme.primaryGradient.createShader(bounds),
                  child: const Text(
                    'GOALFORGE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Sora',
                      letterSpacing: -0.02,
                    ),
                  ),
                ),
              ],
            ),
            Icon(Icons.notifications, color: DashboardTheme.primary, size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Good Evening, Ayush 👋',
          style: TextStyle(
            color: DashboardTheme.onSurface,
            fontSize: 48,
            fontWeight: FontWeight.w700,
            fontFamily: 'Sora',
            letterSpacing: -0.02,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "You're 72% on track this week",
          style: TextStyle(
            color: DashboardTheme.secondary,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            fontFamily: 'Geist',
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildHeroSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 768) {
          return Row(
            children: [
              Expanded(
                flex: 7,
                child: GlassCard(
                  child: const Center(
                    child: WeeklyProgressRing(progress: 0.72, size: 320),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    const AiCoachInsight(),
                    const SizedBox(height: 24),
                    const NextFocusSession(),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              GlassCard(
                child: const Center(
                  child: WeeklyProgressRing(progress: 0.72, size: 280),
                ),
              ),
              const SizedBox(height: 24),
              const AiCoachInsight(),
              const SizedBox(height: 24),
              const NextFocusSession(),
            ],
          );
        }
      },
    );
  }
}
