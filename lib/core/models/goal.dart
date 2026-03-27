import 'plan.dart';

class Goal {
  final String id;
  final String title;
  final String category; // Health, Career, etc.
  final int dailyCommitmentMinutes;
  final Plan? plan;

  Goal({
    required this.id,
    required this.title,
    required this.category,
    required this.dailyCommitmentMinutes,
    this.plan,
  });
}
