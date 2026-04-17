import 'package:flutter/material.dart';
import '../models/goal.dart';
import '../models/task.dart';
import '../models/schedule_item.dart';
import '../models/habit.dart';

class HomeProvider extends ChangeNotifier {
  // Goal Progress
  Goal _goal = Goal(title: 'Complete Flutter Mobile App', progress: 0.68);

  Goal get goal => _goal;

  void updateGoalProgress(double newProgress) {
    _goal = Goal(title: _goal.title, progress: newProgress.clamp(0.0, 1.0));
    notifyListeners();
  }

  void updateGoalTitle(String newTitle) {
    _goal = Goal(title: newTitle, progress: _goal.progress);
    notifyListeners();
  }

  // Task List
  List<Task> _tasks = [
    Task(title: 'Complete UI Design', isCompleted: true),
    Task(title: 'Review Code Changes', isCompleted: false),
    Task(title: 'Team Meeting', isCompleted: false),
  ];

  List<Task> get tasks => List.unmodifiable(_tasks);

  void addTask(String title) {
    _tasks.add(Task(title: title, isCompleted: false));
    notifyListeners();
  }

  void toggleTaskCompletion(int index) {
    if (index >= 0 && index < _tasks.length) {
      _tasks[index] = Task(
        title: _tasks[index].title,
        isCompleted: !_tasks[index].isCompleted,
      );
      notifyListeners();
    }
  }

  void updateTaskTitle(int index, String newTitle) {
    if (index >= 0 && index < _tasks.length) {
      _tasks[index] = Task(
        title: newTitle,
        isCompleted: _tasks[index].isCompleted,
      );
      notifyListeners();
    }
  }

  void deleteTask(int index) {
    if (index >= 0 && index < _tasks.length) {
      _tasks.removeAt(index);
      notifyListeners();
    }
  }

  void reorderTasks(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Task task = _tasks.removeAt(oldIndex);
    _tasks.insert(newIndex, task);
    notifyListeners();
  }

  // Schedule List
  List<ScheduleItem> _scheduleItems = [
    ScheduleItem(
      time: '9:00 AM',
      title: 'Design Review',
      description: 'UI/UX team sync',
    ),
    ScheduleItem(
      time: '10:30 AM',
      title: 'Development Standup',
      description: 'Daily team meeting',
    ),
    ScheduleItem(
      time: '2:00 PM',
      title: 'Sprint Planning',
      description: 'Q2 roadmap discussion',
    ),
    ScheduleItem(
      time: '4:30 PM',
      title: 'Code Review',
      description: 'PR feedback session',
    ),
  ];

  List<ScheduleItem> get scheduleItems => List.unmodifiable(_scheduleItems);

  void addScheduleItem({
    required String time,
    required String title,
    required String description,
  }) {
    _scheduleItems.add(
      ScheduleItem(time: time, title: title, description: description),
    );
    notifyListeners();
  }

  void updateScheduleItem(
    int index, {
    String? time,
    String? title,
    String? description,
  }) {
    if (index >= 0 && index < _scheduleItems.length) {
      final currentItem = _scheduleItems[index];
      _scheduleItems[index] = ScheduleItem(
        time: time ?? currentItem.time,
        title: title ?? currentItem.title,
        description: description ?? currentItem.description,
      );
      notifyListeners();
    }
  }

  void deleteScheduleItem(int index) {
    if (index >= 0 && index < _scheduleItems.length) {
      _scheduleItems.removeAt(index);
      notifyListeners();
    }
  }

  // Habits
  List<Habit> _habits = [
    Habit(name: 'Hydration', icon: Icons.local_drink, isCompleted: false),
    Habit(name: 'Exercise', icon: Icons.directions_run, isCompleted: true),
    Habit(name: 'Meditation', icon: Icons.self_improvement, isCompleted: false),
    Habit(name: 'Reading', icon: Icons.book, isCompleted: false),
    Habit(name: 'Sleep', icon: Icons.nights_stay, isCompleted: false),
    Habit(name: 'Healthy Meals', icon: Icons.restaurant, isCompleted: false),
  ];

  List<Habit> get habits => List.unmodifiable(_habits);

  void addHabit({required String name, required IconData icon}) {
    _habits.add(Habit(name: name, icon: icon, isCompleted: false));
    notifyListeners();
  }

  void toggleHabitCompletion(int index) {
    if (index >= 0 && index < _habits.length) {
      _habits[index] = Habit(
        name: _habits[index].name,
        icon: _habits[index].icon,
        isCompleted: !_habits[index].isCompleted,
      );
      notifyListeners();
    }
  }

  void updateHabitName(int index, String newName) {
    if (index >= 0 && index < _habits.length) {
      _habits[index] = Habit(
        name: newName,
        icon: _habits[index].icon,
        isCompleted: _habits[index].isCompleted,
      );
      notifyListeners();
    }
  }

  void updateHabitIcon(int index, IconData newIcon) {
    if (index >= 0 && index < _habits.length) {
      _habits[index] = Habit(
        name: _habits[index].name,
        icon: newIcon,
        isCompleted: _habits[index].isCompleted,
      );
      notifyListeners();
    }
  }

  void deleteHabit(int index) {
    if (index >= 0 && index < _habits.length) {
      _habits.removeAt(index);
      notifyListeners();
    }
  }

  // Utility methods
  int get completedTasksCount =>
      _tasks.where((task) => task.isCompleted).length;
  int get totalTasksCount => _tasks.length;
  double get tasksCompletionPercentage =>
      totalTasksCount == 0 ? 0.0 : completedTasksCount / totalTasksCount;

  int get completedHabitsCount =>
      _habits.where((habit) => habit.isCompleted).length;
  int get totalHabitsCount => _habits.length;
  double get habitsCompletionPercentage =>
      totalHabitsCount == 0 ? 0.0 : completedHabitsCount / totalHabitsCount;

  // Reset all data
  void resetAllData() {
    _goal = Goal(title: 'Complete Flutter Mobile App', progress: 0.68);
    _tasks = [
      Task(title: 'Complete UI Design', isCompleted: true),
      Task(title: 'Review Code Changes', isCompleted: false),
      Task(title: 'Team Meeting', isCompleted: false),
    ];
    _scheduleItems = [
      ScheduleItem(
        time: '9:00 AM',
        title: 'Design Review',
        description: 'UI/UX team sync',
      ),
      ScheduleItem(
        time: '10:30 AM',
        title: 'Development Standup',
        description: 'Daily team meeting',
      ),
      ScheduleItem(
        time: '2:00 PM',
        title: 'Sprint Planning',
        description: 'Q2 roadmap discussion',
      ),
      ScheduleItem(
        time: '4:30 PM',
        title: 'Code Review',
        description: 'PR feedback session',
      ),
    ];
    _habits = [
      Habit(name: 'Hydration', icon: Icons.local_drink, isCompleted: false),
      Habit(name: 'Exercise', icon: Icons.directions_run, isCompleted: true),
      Habit(
        name: 'Meditation',
        icon: Icons.self_improvement,
        isCompleted: false,
      ),
      Habit(name: 'Reading', icon: Icons.book, isCompleted: false),
      Habit(name: 'Sleep', icon: Icons.nights_stay, isCompleted: false),
      Habit(name: 'Healthy Meals', icon: Icons.restaurant, isCompleted: false),
    ];
    notifyListeners();
  }
}
