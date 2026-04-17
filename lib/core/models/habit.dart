import 'package:flutter/material.dart';

class Habit {
  final String name;
  final IconData icon;
  final bool isCompleted;

  Habit({
    required this.name,
    required this.icon,
    required this.isCompleted,
  });
}
