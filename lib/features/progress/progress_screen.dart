import 'package:flutter/material.dart';
import 'dart:math' as math;

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen>
    with TickerProviderStateMixin {
  late AnimationController _streakController;
  late AnimationController _barController;

  @override
  void initState() {
    super.initState();
    _streakController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();
    _barController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _streakController.dispose();
    _barController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131314),
      body: Stack(
        children: [
          _buildBackgroundGlow(),
          SafeArea(
            child: Column(
              children: [
                _buildTopAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        _buildHeroHeader(),
                        const SizedBox(height: 24),
                        _buildBentoGrid(),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundGlow() {
    return Positioned.fill(
      child: Stack(
        children: [
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFD0BCFF).withValues(alpha: 0.08),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD0BCFF).withValues(alpha: 0.12),
                    blurRadius: 120,
                    spreadRadius: 60,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF89CEFF).withValues(alpha: 0.08),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF89CEFF).withValues(alpha: 0.12),
                    blurRadius: 100,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopAppBar() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFD0BCFF).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.bolt,
                  color: Color(0xFFD0BCFF),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFFD0BCFF), Color(0xFF89CEFF)],
                ).createShader(bounds),
                child: const Text(
                  'GOALFORGE',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
              color: Color(0xFFCBC3D7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Analytics',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Color(0xFFE5E2E3),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Deep dive into your performance and consistency trends.',
          style: TextStyle(
            fontSize: 16,
            color: const Color(0xFFCBC3D7).withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildBentoGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 8,
              child: _buildProductivityCard(),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 4,
              child: _buildStreakCard(),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildHeatmapCard(),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 7,
              child: _buildFocusDeepWorkCard(),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 5,
              child: _buildGoalCompletionCard(),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildBadgesCard(),
      ],
    );
  }

  Widget _buildProductivityCard() {
    final barHeights = [48.0, 96.0, 128.0, 80.0, 112.0, 160.0, 64.0];
    final barColors = [
      const Color(0xFF353436),
      const Color(0xFF353436),
      const Color(0xFFD0BCFF),
      const Color(0xFF353436),
      const Color(0xFF89CEFF),
      const Color(0xFFD0BCFF),
      const Color(0xFF353436),
    ];
    final days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    final activeDays = [false, false, true, false, false, true, false];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFFFFFF).withValues(alpha: 0.03),
            const Color(0xFFFFFFFF).withValues(alpha: 0.01),
          ],
        ),
        border: Border.all(
          color: const Color(0xFFFFFFFF).withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'WEEKLY OUTPUT',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                      color: const Color(0xFFD0BCFF).withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Productivity',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFE5E2E3),
                    ),
                  ),
                ],
              ),
              Row(
                children: List.generate(
                  7,
                  (index) => AnimatedBuilder(
                    animation: _barController,
                    builder: (context, child) {
                      return Container(
                        margin: const EdgeInsets.only(left: 4),
                        width: 32,
                        height: barHeights[index] * _barController.value,
                        decoration: BoxDecoration(
                          color: barColors[index],
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: activeDays[index]
                              ? [
                                  BoxShadow(
                                    color: barColors[index].withValues(alpha: 0.3),
                                    blurRadius: 15,
                                  ),
                                ]
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(color: Color(0x0AFFFFFF)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              7,
              (index) => Text(
                days[index],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: activeDays[index]
                      ? (index == 2 || index == 5
                          ? const Color(0xFFD0BCFF)
                          : const Color(0xFF89CEFF))
                      : const Color(0xFF958EA0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreakCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFFFFFF).withValues(alpha: 0.03),
            const Color(0xFFFFFFFF).withValues(alpha: 0.01),
          ],
        ),
        border: Border.all(
          color: const Color(0xFFFFFFFF).withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'STREAK ANALYTICS',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
              color: const Color(0xFF89CEFF),
            ),
          ),
          const SizedBox(height: 16),
          AnimatedBuilder(
            animation: _streakController,
            builder: (context, child) {
              return SizedBox(
                width: 128,
                height: 128,
                child: CustomPaint(
                  painter: _StreakRingPainter(
                    progress: _streakController.value * 0.78,
                    glowColor: const Color(0xFF89CEFF),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '14',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFE5E2E3),
                          ),
                        ),
                        const Text(
                          'DAYS',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF958EA0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Text(
            '4 days until your next milestone.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFFCBC3D7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeatmapCard() {
    final heatmapData = _generateHeatmapData();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFFFFFF).withValues(alpha: 0.03),
            const Color(0xFFFFFFFF).withValues(alpha: 0.01),
          ],
        ),
        border: Border.all(
          color: const Color(0xFFFFFFFF).withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Consistency Heatmap',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFE5E2E3),
                ),
              ),
              Row(
                children: [
                  const Text(
                    'Less',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF958EA0),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Container(
                        margin: const EdgeInsets.only(left: 4),
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD0BCFF).withValues(
                            alpha: 0.2 + (index * 0.2),
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'More',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF958EA0),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 26,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: heatmapData.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: heatmapData[index],
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFocusDeepWorkCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFFFFFF).withValues(alpha: 0.03),
            const Color(0xFFFFFFFF).withValues(alpha: 0.01),
          ],
        ),
        border: Border.all(
          color: const Color(0xFFFFFFFF).withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Focus Deep Work',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFE5E2E3),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF4EDEA3).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '+12% vs last week',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4EDEA3),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 192,
            child: CustomPaint(
              painter: _LineGraphPainter(),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '08:00',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF958EA0),
                ),
              ),
              Text(
                '12:00',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF958EA0),
                ),
              ),
              Text(
                '16:00',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF958EA0),
                ),
              ),
              Text(
                '20:00',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF958EA0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCompletionCard() {
    final goals = [
      {'name': 'Main Objective', 'progress': 0.82, 'color': const Color(0xFFD0BCFF)},
      {'name': 'Habit Formation', 'progress': 0.45, 'color': const Color(0xFF89CEFF)},
      {'name': 'Side Quests', 'progress': 0.95, 'color': const Color(0xFF4EDEA3)},
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFFFFFF).withValues(alpha: 0.03),
            const Color(0xFFFFFFFF).withValues(alpha: 0.01),
          ],
        ),
        border: Border.all(
          color: const Color(0xFFFFFFFF).withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Goal Completion',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFFE5E2E3),
            ),
          ),
          const SizedBox(height: 24),
          ...goals.map((goal) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          goal['name'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFE5E2E3),
                          ),
                        ),
                        Text(
                          '${((goal['progress'] as double) * 100).toInt()}%',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: goal['color'] as Color,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: const Color(0xFF353436),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: goal['progress'] as double,
                          backgroundColor: Colors.transparent,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            goal['color'] as Color,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildBadgesCard() {
    final badges = [
      {'icon': Icons.workspace_premium, 'name': 'Alpha User', 'color': const Color(0xFFD0BCFF), 'unlocked': true},
      {'icon': Icons.local_fire_department, 'name': 'Heat Wave', 'color': const Color(0xFF89CEFF), 'unlocked': true},
      {'icon': Icons.my_location, 'name': 'Sniper', 'color': const Color(0xFF4EDEA3), 'unlocked': true},
      {'icon': Icons.lock, 'name': 'God Mode', 'color': const Color(0xFF958EA0), 'unlocked': false},
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFFFFFF).withValues(alpha: 0.03),
            const Color(0xFFFFFFFF).withValues(alpha: 0.01),
          ],
        ),
        border: Border.all(
          color: const Color(0xFFFFFFFF).withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Unlocked Badges',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFE5E2E3),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFD0BCFF),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 32,
            runSpacing: 24,
            children: badges.map((badge) {
              final isUnlocked = badge['unlocked'] as bool;
              return Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: isUnlocked
                          ? LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                (badge['color'] as Color).withValues(alpha: 0.2),
                                (badge['color'] as Color).withValues(alpha: 0.05),
                              ],
                            )
                          : null,
                      color: isUnlocked ? null : const Color(0xFF353436),
                      border: Border.all(
                        color: isUnlocked
                            ? (badge['color'] as Color).withValues(alpha: 0.2)
                            : const Color(0xFFFFFFFF).withValues(alpha: 0.05),
                        width: 1,
                      ),
                      boxShadow: isUnlocked
                          ? [
                              BoxShadow(
                                color: (badge['color'] as Color).withValues(alpha: 0.2),
                                blurRadius: 15,
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      badge['icon'] as IconData,
                      color: isUnlocked
                          ? badge['color'] as Color
                          : const Color(0xFF958EA0),
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    badge['name'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isUnlocked
                          ? const Color(0xFFE5E2E3)
                          : const Color(0xFF958EA0),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  List<Color> _generateHeatmapData() {
    final random = math.Random(42);
    return List.generate(
      182,
      (index) {
        final value = random.nextDouble();
        if (value < 0.3) {
          return const Color(0xFF353436);
        } else if (value < 0.5) {
          return const Color(0xFFD0BCFF).withValues(alpha: 0.2);
        } else if (value < 0.7) {
          return const Color(0xFFD0BCFF).withValues(alpha: 0.4);
        } else if (value < 0.9) {
          return const Color(0xFFD0BCFF).withValues(alpha: 0.7);
        } else {
          return const Color(0xFFD0BCFF);
        }
      },
    );
  }
}

class _StreakRingPainter extends CustomPainter {
  final double progress;
  final Color glowColor;

  _StreakRingPainter({required this.progress, required this.glowColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;
    final strokeWidth = 8.0;

    final backgroundPaint = Paint()
      ..color = const Color(0xFF353436)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, backgroundPaint);

    final progressPaint = Paint()
      ..color = glowColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_StreakRingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _LineGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD0BCFF)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    final points = [
      Offset(0, size.height * 0.875),
      Offset(size.width * 0.2, size.height * 0.5),
      Offset(size.width * 0.4, size.height * 0.625),
      Offset(size.width * 0.6, size.height * 0.375),
      Offset(size.width * 0.8, size.height * 0.125),
      Offset(size.width, size.height * 0.3),
    ];

    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      final x = (points[i].dx + points[i - 1].dx) / 2;
      final y = (points[i].dy + points[i - 1].dy) / 2;
      path.quadraticBezierTo(
        points[i - 1].dx,
        points[i - 1].dy,
        x,
        y,
      );
    }
    path.quadraticBezierTo(
      points[points.length - 1].dx,
      points[points.length - 1].dy,
      points[points.length - 1].dx,
      points[points.length - 1].dy,
    );

    canvas.drawPath(path, paint);

    final linePaint = Paint()
      ..color = const Color(0xFFFFFFFF).withValues(alpha: 0.1)
      ..strokeWidth = 1;

    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, size.height),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(_LineGraphPainter oldDelegate) {
    return false;
  }
}
