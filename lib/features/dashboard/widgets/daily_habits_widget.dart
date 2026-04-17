import 'package:flutter/material.dart';

class DailyHabitsWidget extends StatefulWidget {
  const DailyHabitsWidget({super.key});

  @override
  State<DailyHabitsWidget> createState() => _DailyHabitsWidgetState();
}

class _DailyHabitsWidgetState extends State<DailyHabitsWidget> {
  final List<HabitItem> habits = [
    HabitItem(
      icon: Icons.local_drink,
      title: 'Hydration',
      target: '8 glasses',
      current: 5,
      max: 8,
      color: const Color(0xFF2196F3),
    ),
    HabitItem(
      icon: Icons.directions_run,
      title: 'Exercise',
      target: '30 min',
      current: 30,
      max: 30,
      color: const Color(0xFFFF5722),
    ),
    HabitItem(
      icon: Icons.self_improvement,
      title: 'Meditation',
      target: '15 min',
      current: 10,
      max: 15,
      color: const Color(0xFF9C27B0),
    ),
    HabitItem(
      icon: Icons.book,
      title: 'Reading',
      target: '20 pages',
      current: 12,
      max: 20,
      color: const Color(0xFF4CAF50),
    ),
    HabitItem(
      icon: Icons.nights_stay,
      title: 'Sleep',
      target: '8 hours',
      current: 7,
      max: 8,
      color: const Color(0xFF3F51B5),
    ),
    HabitItem(
      icon: Icons.restaurant,
      title: 'Healthy Meals',
      target: '3 meals',
      current: 2,
      max: 3,
      color: const Color(0xFFFF9800),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1B4332),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF4CAF50).withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.repeat,
                  color: Color(0xFF4CAF50),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Daily Habits',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '67% complete',
                  style: TextStyle(
                    color: Color(0xFF4CAF50),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.4,
            ),
            itemCount: habits.length,
            itemBuilder: (context, index) {
              final habit = habits[index];
              return _buildHabitCard(habit);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHabitCard(HabitItem habit) {
    final progress = habit.current / habit.max;
    final isCompleted = progress >= 1.0;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1F0D),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCompleted 
              ? const Color(0xFF4CAF50).withValues(alpha: 0.4)
              : habit.color.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: habit.color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  habit.icon,
                  color: habit.color,
                  size: 16,
                ),
              ),
              const Spacer(),
              if (isCompleted)
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            habit.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            habit.target,
            style: TextStyle(
              color: const Color(0xFF81C784).withValues(alpha: 0.8),
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${habit.current}/${habit.max}',
                    style: TextStyle(
                      color: isCompleted 
                          ? const Color(0xFF4CAF50)
                          : const Color(0xFF81C784),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${(progress * 100).round()}%',
                    style: TextStyle(
                      color: isCompleted 
                          ? const Color(0xFF4CAF50)
                          : habit.color,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Container(
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFF0D1F0D),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress.clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isCompleted 
                          ? const Color(0xFF4CAF50)
                          : habit.color,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HabitItem {
  final IconData icon;
  final String title;
  final String target;
  final int current;
  final int max;
  final Color color;

  HabitItem({
    required this.icon,
    required this.title,
    required this.target,
    required this.current,
    required this.max,
    required this.color,
  });
}
