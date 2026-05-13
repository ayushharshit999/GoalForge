import 'package:flutter/material.dart';
import '../dashboard_theme.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: DashboardTheme.surfaceContainerLowest.withValues(alpha: 0.3),
        border: Border(
          top: BorderSide(color: DashboardTheme.glassBorder, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: DashboardTheme.primary.withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(icon: Icons.home, label: 'Home', isActive: true),
              _buildNavItem(
                icon: Icons.route,
                label: 'Roadmap',
                isActive: false,
              ),
              _buildNavItem(icon: Icons.timer, label: 'Focus', isActive: false),
              _buildNavItem(
                icon: Icons.insights,
                label: 'Progress',
                isActive: false,
              ),
              _buildNavItem(
                icon: Icons.person,
                label: 'Profile',
                isActive: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? DashboardTheme.primary : DashboardTheme.outline,
          size: 24,
        ),
        const SizedBox(height: 4),
        if (isActive)
          Container(
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              color: DashboardTheme.primary,
              shape: BoxShape.circle,
            ),
          ),
        Text(
          label,
          style: TextStyle(
            color: isActive ? DashboardTheme.primary : DashboardTheme.outline,
            fontSize: 12,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            fontFamily: 'JetBrains Mono',
            letterSpacing: 0.05,
          ),
        ),
      ],
    );
  }
}
