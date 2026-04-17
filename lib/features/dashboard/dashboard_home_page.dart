import 'package:flutter/material.dart';
import '../dashboard/widgets/dashboard_header.dart';
import '../dashboard/widgets/goal_progress_widget.dart';
import '../dashboard/widgets/priorities_widget.dart';
import '../dashboard/widgets/schedule_widget.dart';
import '../dashboard/widgets/daily_habits_widget.dart';

class DashboardHomePage extends StatelessWidget {
  const DashboardHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1F0D),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DashboardHeader(),
              const SizedBox(height: 24),
              const GoalProgressWidget(),
              const SizedBox(height: 24),
              const PrioritiesWidget(),
              const SizedBox(height: 24),
              const ScheduleWidget(),
              const SizedBox(height: 24),
              const DailyHabitsWidget(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
