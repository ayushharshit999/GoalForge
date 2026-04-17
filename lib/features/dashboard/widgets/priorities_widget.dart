import 'package:flutter/material.dart';

class PrioritiesWidget extends StatefulWidget {
  const PrioritiesWidget({super.key});

  @override
  State<PrioritiesWidget> createState() => _PrioritiesWidgetState();
}

class _PrioritiesWidgetState extends State<PrioritiesWidget> {
  final List<PriorityItem> priorities = [
    PriorityItem(
      title: 'Complete UI Design',
      description: 'Finalize dashboard mockups',
      isCompleted: true,
      priority: Priority.high,
    ),
    PriorityItem(
      title: 'Review Code Changes',
      description: 'Check pull requests',
      isCompleted: false,
      priority: Priority.medium,
    ),
    PriorityItem(
      title: 'Team Meeting',
      description: 'Sprint planning at 2 PM',
      isCompleted: false,
      priority: Priority.high,
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
                  Icons.priority_high,
                  color: Color(0xFF4CAF50),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Top 3 Priorities',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...priorities.asMap().entries.map((entry) {
            final index = entry.key;
            final priority = entry.value;
            return Padding(
              padding: EdgeInsets.only(bottom: index < priorities.length - 1 ? 12 : 0),
              child: _buildPriorityItem(priority),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPriorityItem(PriorityItem priority) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1F0D),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: priority.isCompleted 
              ? const Color(0xFF4CAF50).withValues(alpha: 0.3)
              : const Color(0xFF4CAF50).withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                priority.isCompleted = !priority.isCompleted;
              });
            },
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: priority.isCompleted 
                      ? const Color(0xFF4CAF50)
                      : const Color(0xFF81C784),
                  width: 2,
                ),
                color: priority.isCompleted 
                    ? const Color(0xFF4CAF50)
                    : Colors.transparent,
              ),
              child: priority.isCompleted
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 14,
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      priority.title,
                      style: TextStyle(
                        color: priority.isCompleted 
                            ? const Color(0xFF81C784)
                            : Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        decoration: priority.isCompleted 
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getPriorityColor(priority.priority),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        priority.priority.name.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  priority.description,
                  style: TextStyle(
                    color: const Color(0xFF81C784).withValues(alpha: 0.8),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.high:
        return const Color(0xFFE53935);
      case Priority.medium:
        return const Color(0xFFFB8C00);
      case Priority.low:
        return const Color(0xFF4CAF50);
    }
  }
}

class PriorityItem {
  final String title;
  final String description;
  final Priority priority;
  bool isCompleted;

  PriorityItem({
    required this.title,
    required this.description,
    required this.priority,
    required this.isCompleted,
  });
}

enum Priority { high, medium, low }
