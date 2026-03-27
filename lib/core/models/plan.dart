import 'priority_task.dart';
import 'schedule_item.dart';
import 'habit.dart';

class Plan {
  final List<PriorityTask> priorities;
  final List<ScheduleItem> schedule;
  final List<Habit> habits;

  Plan({
    required this.priorities,
    required this.schedule,
    required this.habits,
  });
}
