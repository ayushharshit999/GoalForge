import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/providers/home_provider.dart';
import '../../../../core/models/task.dart';

class PrioritiesWidget extends StatelessWidget {
  const PrioritiesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final tasks = homeProvider.tasks.take(3).toList(); // Show top 3 tasks as priorities

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
          ...tasks.asMap().entries.map((entry) {
            final index = entry.key;
            final task = entry.value;
            return Padding(
              padding: EdgeInsets.only(bottom: index < tasks.length - 1 ? 12 : 0),
              child: _buildPriorityItem(task, index, homeProvider),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPriorityItem(Task task, int index, HomeProvider homeProvider) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1F0D),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: task.isCompleted 
              ? const Color(0xFF4CAF50).withValues(alpha: 0.3)
              : const Color(0xFF4CAF50).withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              homeProvider.toggleTaskCompletion(index);
            },
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: task.isCompleted 
                      ? const Color(0xFF4CAF50)
                      : const Color(0xFF81C784),
                  width: 2,
                ),
                color: task.isCompleted 
                    ? const Color(0xFF4CAF50)
                    : Colors.transparent,
              ),
              child: task.isCompleted
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
                      task.title,
                      style: TextStyle(
                        color: task.isCompleted 
                            ? const Color(0xFF81C784)
                            : Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        decoration: task.isCompleted 
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getPriorityColor(index),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _getPriorityLabel(index),
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
                  'Priority task ${index + 1}',
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

  Color _getPriorityColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xFFE53935); // HIGH
      case 1:
        return const Color(0xFFFB8C00); // MEDIUM
      case 2:
        return const Color(0xFF4CAF50); // LOW
      default:
        return const Color(0xFFE53935);
    }
  }

  String _getPriorityLabel(int index) {
    switch (index) {
      case 0:
        return 'HIGH';
      case 1:
        return 'MEDIUM';
      case 2:
        return 'LOW';
      default:
        return 'HIGH';
    }
  }
}
