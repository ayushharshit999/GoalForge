import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../dashboard_theme.dart';

class WeeklyProgressRing extends StatelessWidget {
  final double progress;
  final double size;

  const WeeklyProgressRing({
    super.key,
    required this.progress,
    this.size = 320,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _ProgressRingPainter(
          progress: progress,
          backgroundColor: DashboardTheme.surfaceContainerHighest,
          gradientColors: [DashboardTheme.primary, DashboardTheme.secondary],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${(progress * 100).toInt()}',
                    style: const TextStyle(
                      color: DashboardTheme.onSurface,
                      fontSize: 64,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Sora',
                      height: 1.1,
                    ),
                  ),
                  const Text(
                    '%',
                    style: TextStyle(
                      color: DashboardTheme.onSurface,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Sora',
                      height: 1.3,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'WEEKLY GOAL',
                style: TextStyle(
                  color: DashboardTheme.outline,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'JetBrains Mono',
                  letterSpacing: 0.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final List<Color> gradientColors;

  _ProgressRingPainter({
    required this.progress,
    required this.backgroundColor,
    required this.gradientColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.45;
    final strokeWidth = size.width * 0.08;

    // Background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress arc with gradient
    final rect = Rect.fromCircle(center: center, radius: radius);
    final startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;

    final gradient = SweepGradient(
      startAngle: startAngle,
      endAngle: startAngle + sweepAngle,
      colors: gradientColors,
      tileMode: TileMode.repeated,
    );

    final progressPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);

    canvas.drawArc(rect, startAngle, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(_ProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
