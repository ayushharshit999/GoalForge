import 'goal.dart';

class AppUser {
  final String id;
  final String email;
  final String focusArea;
  final Goal? activeGoal;

  AppUser({
    required this.id,
    required this.email,
    required this.focusArea,
    this.activeGoal,
  });
}
