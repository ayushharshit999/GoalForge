import 'package:flutter/material.dart';
import 'dart:math' as math;

class RoadmapJourneyScreen extends StatefulWidget {
  const RoadmapJourneyScreen({super.key});

  @override
  State<RoadmapJourneyScreen> createState() => _RoadmapJourneyScreenState();
}

class _RoadmapJourneyScreenState extends State<RoadmapJourneyScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _progressController;
  int? _expandedModuleIndex;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _progressController.dispose();
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        _buildHeroHeader(),
                        const SizedBox(height: 24),
                        _buildRoadmapOverviewCard(),
                        const SizedBox(height: 32),
                        _buildRoadmapTimeline(),
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildStickyBottomActionCard(),
          _buildFloatingAIButton(),
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
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFD0BCFF).withValues(alpha: 0.05),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD0BCFF).withValues(alpha: 0.1),
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
                color: const Color(0xFF89CEFF).withValues(alpha: 0.05),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF89CEFF).withValues(alpha: 0.1),
                    blurRadius: 120,
                    spreadRadius: 60,
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
              Text(
                'GOALFORGE',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: [Color(0xFFD0BCFF), Color(0xFF89CEFF)],
                    ).createShader(const Rect.fromLTWH(0, 0, 200, 20)),
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
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF89CEFF).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'AI-GENERATED PATH',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.5,
                          color: Color(0xFF89CEFF),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Become Data Scientist',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFE5E2E3),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Master ML, AI, and data analytics',
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color(0xFFCBC3D7),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              _buildCircularProgressRing(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircularProgressRing() {
    return SizedBox(
      width: 100,
      height: 100,
      child: AnimatedBuilder(
        animation: _progressController,
        builder: (context, child) {
          return CustomPaint(
            painter: _ProgressRingPainter(
              progress: _progressController.value * 0.72,
              glowColor: const Color(0xFFD0BCFF),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${(_progressController.value * 72).toInt()}%',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFD0BCFF),
                    ),
                  ),
                  const Text(
                    'Complete',
                    style: TextStyle(fontSize: 10, color: Color(0xFFCBC3D7)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRoadmapOverviewCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
                'Roadmap Overview',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFE5E2E3),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFD0BCFF), Color(0xFF89CEFF)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Phase 3/6',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF340080),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildStatItem('2,450', 'XP Earned', Icons.star_outline),
              const SizedBox(width: 20),
              _buildStatItem(
                '12',
                'Day Streak',
                Icons.local_fire_department_outlined,
              ),
              const SizedBox(width: 20),
              _buildStatItem('45h', 'Est. Time', Icons.schedule_outlined),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFF353436),
              borderRadius: BorderRadius.circular(4),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: 0.72,
                backgroundColor: Colors.transparent,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFFD0BCFF),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '72% Complete',
                style: TextStyle(fontSize: 12, color: Color(0xFFCBC3D7)),
              ),
              Text(
                '~18 hours remaining',
                style: TextStyle(fontSize: 12, color: const Color(0xFF89CEFF)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1B1C),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFFD0BCFF), size: 20),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFFE5E2E3),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: Color(0xFFCBC3D7)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoadmapTimeline() {
    final modules = _getDummyModules();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Learning Journey',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFFE5E2E3),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Follow your personalized path to mastery',
          style: TextStyle(fontSize: 14, color: const Color(0xFFCBC3D7)),
        ),
        const SizedBox(height: 24),
        Stack(
          children: [
            Positioned(
              left: 11,
              top: 0,
              bottom: 0,
              child: Container(
                width: 2,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFD0BCFF), Color(0xFF89CEFF)],
                  ),
                ),
              ),
            ),
            ...modules.asMap().entries.map((entry) {
              final index = entry.key;
              final module = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: _buildModuleCard(module, index),
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildModuleCard(RoadmapModule module, int index) {
    final isExpanded = _expandedModuleIndex == index;
    final isCompleted = module.status == ModuleStatus.completed;
    final isCurrent = module.status == ModuleStatus.current;
    final isLocked = module.status == ModuleStatus.locked;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildModuleIndicator(module.status),
            const SizedBox(width: 16),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (!isLocked) {
                    setState(() {
                      _expandedModuleIndex = isExpanded ? null : index;
                    });
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: EdgeInsets.all(isExpanded ? 20 : 16),
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
                      color: _getModuleBorderColor(module.status),
                      width: isCurrent ? 2 : 1,
                    ),
                    boxShadow: isCurrent
                        ? [
                            BoxShadow(
                              color: const Color(
                                0xFF89CEFF,
                              ).withValues(alpha: 0.2),
                              blurRadius: 20,
                              spreadRadius: 0,
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              module.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isLocked
                                    ? const Color(
                                        0xFFCBC3D7,
                                      ).withValues(alpha: 0.5)
                                    : const Color(0xFFE5E2E3),
                              ),
                            ),
                          ),
                          _buildStatusBadge(module.status),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        module.description,
                        style: TextStyle(
                          fontSize: 13,
                          color: isLocked
                              ? const Color(0xFFCBC3D7).withValues(alpha: 0.4)
                              : const Color(0xFFCBC3D7),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _buildChip(Icons.timer_outlined, module.duration),
                          const SizedBox(width: 8),
                          _buildDifficultyBadge(module.difficulty),
                          if (module.isAISuggested) ...[
                            const SizedBox(width: 8),
                            _buildAISuggestedChip(),
                          ],
                        ],
                      ),
                      if (isExpanded && !isLocked) ...[
                        const SizedBox(height: 16),
                        const Divider(color: Color(0xFF353436)),
                        const SizedBox(height: 16),
                        _buildModuleDetails(module),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildModuleIndicator(ModuleStatus status) {
    switch (status) {
      case ModuleStatus.completed:
        return Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF4EDEA3),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4EDEA3).withValues(alpha: 0.4),
                blurRadius: 12,
              ),
            ],
          ),
          child: const Icon(Icons.check, color: Color(0xFF002113), size: 14),
        );
      case ModuleStatus.current:
        return AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF89CEFF),
                boxShadow: [
                  BoxShadow(
                    color: const Color(
                      0xFF89CEFF,
                    ).withValues(alpha: 0.3 + _pulseController.value * 0.3),
                    blurRadius: 12 + _pulseController.value * 8,
                  ),
                ],
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Color(0xFF001E2F),
                size: 14,
              ),
            );
          },
        );
      case ModuleStatus.locked:
        return Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF494454), width: 2),
            color: const Color(0xFF131314),
          ),
          child: const Icon(
            Icons.lock_outline,
            color: Color(0xFF494454),
            size: 12,
          ),
        );
    }
  }

  Widget _buildStatusBadge(ModuleStatus status) {
    switch (status) {
      case ModuleStatus.completed:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF4EDEA3).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Completed',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4EDEA3),
            ),
          ),
        );
      case ModuleStatus.current:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF89CEFF).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'In Progress',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF89CEFF),
            ),
          ),
        );
      case ModuleStatus.locked:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF494454).withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Locked',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF958EA0),
            ),
          ),
        );
    }
  }

  Color _getModuleBorderColor(ModuleStatus status) {
    switch (status) {
      case ModuleStatus.completed:
        return const Color(0xFF4EDEA3).withValues(alpha: 0.3);
      case ModuleStatus.current:
        return const Color(0xFF89CEFF).withValues(alpha: 0.5);
      case ModuleStatus.locked:
        return const Color(0xFFFFFFFF).withValues(alpha: 0.05);
    }
  }

  Widget _buildChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF89CEFF), size: 14),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(fontSize: 11, color: Color(0xFFE5E2E3)),
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultyBadge(Difficulty difficulty) {
    Color color;
    String text;
    switch (difficulty) {
      case Difficulty.beginner:
        color = const Color(0xFF4EDEA3);
        text = 'Beginner';
        break;
      case Difficulty.intermediate:
        color = const Color(0xFF89CEFF);
        text = 'Intermediate';
        break;
      case Difficulty.advanced:
        color = const Color(0xFFD0BCFF);
        text = 'Advanced';
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildAISuggestedChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFD0BCFF).withValues(alpha: 0.2),
            const Color(0xFF89CEFF).withValues(alpha: 0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.auto_awesome, color: Color(0xFFD0BCFF), size: 12),
          const SizedBox(width: 4),
          const Text(
            'AI Suggested',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFFD0BCFF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModuleDetails(RoadmapModule module) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailSection('Topics Covered', module.topics),
        const SizedBox(height: 12),
        _buildDetailSection('Mini Projects', module.projects),
        const SizedBox(height: 12),
        _buildDetailSection('Skills Gained', module.skills),
        const SizedBox(height: 12),
        _buildDetailSection('Practice Tasks', module.tasks),
        const SizedBox(height: 12),
        _buildDetailSection('Resources', module.resources),
      ],
    );
  }

  Widget _buildDetailSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFFD0BCFF),
          ),
        ),
        const SizedBox(height: 8),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF89CEFF),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFFCBC3D7),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStickyBottomActionCard() {
    return Positioned(
      left: 20,
      right: 20,
      bottom: 100,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFFFFFFF).withValues(alpha: 0.05),
              const Color(0xFFFFFFFF).withValues(alpha: 0.02),
            ],
          ),
          border: Border.all(
            color: const Color(0xFFFFFFFF).withValues(alpha: 0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF131314).withValues(alpha: 0.8),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Today's Target",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFCBC3D7),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Complete ML Models module',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFE5E2E3),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF89CEFF).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '2h 30m left',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF89CEFF),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFD0BCFF), Color(0xFF89CEFF)],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFD0BCFF).withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.play_arrow_rounded,
                          color: Color(0xFF340080),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Continue Learning',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF340080),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.auto_awesome,
                  color: Color(0xFFD0BCFF),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "You're making great progress! Keep up the momentum.",
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color(0xFFCBC3D7),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingAIButton() {
    return Positioned(
      right: 20,
      bottom: 100,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFD0BCFF), Color(0xFF89CEFF)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFD0BCFF).withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(16),
            child: const Icon(
              Icons.smart_toy_outlined,
              color: Color(0xFF340080),
              size: 28,
            ),
          ),
        ),
      ),
    );
  }

  List<RoadmapModule> _getDummyModules() {
    return [
      RoadmapModule(
        title: 'Python Basics',
        description: 'Master Python fundamentals for data science',
        duration: '8h',
        difficulty: Difficulty.beginner,
        status: ModuleStatus.completed,
        isAISuggested: false,
        topics: [
          'Variables & Data Types',
          'Control Flow',
          'Functions',
          'OOP Basics',
        ],
        projects: ['Number Guessing Game', 'To-Do List App'],
        skills: ['Python Syntax', 'Problem Solving', 'Debugging'],
        tasks: ['Complete 5 coding exercises', 'Build 2 mini projects'],
        resources: ['Python Docs', 'Real Python Tutorials'],
      ),
      RoadmapModule(
        title: 'Data Analysis',
        description: 'Learn to analyze and visualize data effectively',
        duration: '12h',
        difficulty: Difficulty.intermediate,
        status: ModuleStatus.completed,
        isAISuggested: true,
        topics: ['Pandas', 'NumPy', 'Matplotlib', 'Seaborn'],
        projects: ['Sales Dashboard', 'Customer Segmentation'],
        skills: ['Data Cleaning', 'Visualization', 'Statistical Analysis'],
        tasks: ['Analyze 3 datasets', 'Create 5 visualizations'],
        resources: ['Kaggle Learn', 'DataCamp'],
      ),
      RoadmapModule(
        title: 'Machine Learning',
        description: 'Build and deploy ML models',
        duration: '15h',
        difficulty: Difficulty.intermediate,
        status: ModuleStatus.current,
        isAISuggested: true,
        topics: [
          'Supervised Learning',
          'Unsupervised Learning',
          'Model Evaluation',
          'Scikit-learn',
        ],
        projects: ['House Price Predictor', 'Email Classifier'],
        skills: [
          'Model Training',
          'Feature Engineering',
          'Hyperparameter Tuning',
        ],
        tasks: ['Build 3 ML models', 'Complete 2 projects'],
        resources: ['Coursera ML Course', 'Scikit-learn Docs'],
      ),
      RoadmapModule(
        title: 'Deep Learning',
        description: 'Neural networks and advanced AI concepts',
        duration: '20h',
        difficulty: Difficulty.advanced,
        status: ModuleStatus.locked,
        isAISuggested: true,
        topics: ['Neural Networks', 'CNNs', 'RNNs', 'TensorFlow'],
        projects: ['Image Classifier', 'Sentiment Analysis'],
        skills: ['Deep Learning', 'TensorFlow', 'Model Optimization'],
        tasks: ['Build 2 neural networks', 'Complete capstone project'],
        resources: ['Deep Learning Specialization', 'TensorFlow Tutorials'],
      ),
      RoadmapModule(
        title: 'MLOps',
        description: 'Deploy and maintain ML systems in production',
        duration: '10h',
        difficulty: Difficulty.advanced,
        status: ModuleStatus.locked,
        isAISuggested: false,
        topics: ['Model Deployment', 'CI/CD for ML', 'Monitoring', 'Scaling'],
        projects: ['ML Pipeline', 'Model API'],
        skills: ['Docker', 'Cloud Deployment', 'ML Monitoring'],
        tasks: ['Deploy 2 models', 'Set up monitoring'],
        resources: ['MLOps Course', 'AWS ML Docs'],
      ),
      RoadmapModule(
        title: 'Portfolio Projects',
        description: 'Build end-to-end data science projects',
        duration: '25h',
        difficulty: Difficulty.advanced,
        status: ModuleStatus.locked,
        isAISuggested: false,
        topics: [
          'Project Planning',
          'Data Collection',
          'Model Deployment',
          'Documentation',
        ],
        projects: ['Complete Portfolio', 'Case Studies'],
        skills: ['Full Stack ML', 'Project Management', 'Communication'],
        tasks: ['Build 3 portfolio projects', 'Write documentation'],
        resources: ['Portfolio Templates', 'GitHub Projects'],
      ),
    ];
  }
}

class _ProgressRingPainter extends CustomPainter {
  final double progress;
  final Color glowColor;

  _ProgressRingPainter({required this.progress, required this.glowColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;
    final strokeWidth = 8.0;

    final backgroundPaint = Paint()
      ..color = const Color(0xFF353436)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    final gradient = SweepGradient(
      startAngle: -math.pi / 2,
      endAngle: -math.pi / 2 + 2 * math.pi * progress,
      colors: [const Color(0xFFD0BCFF), const Color(0xFF89CEFF)],
    );

    final progressPaint = Paint()
      ..shader = gradient.createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_ProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

enum ModuleStatus { completed, current, locked }

enum Difficulty { beginner, intermediate, advanced }

class RoadmapModule {
  final String title;
  final String description;
  final String duration;
  final Difficulty difficulty;
  final ModuleStatus status;
  final bool isAISuggested;
  final List<String> topics;
  final List<String> projects;
  final List<String> skills;
  final List<String> tasks;
  final List<String> resources;

  RoadmapModule({
    required this.title,
    required this.description,
    required this.duration,
    required this.difficulty,
    required this.status,
    required this.isAISuggested,
    required this.topics,
    required this.projects,
    required this.skills,
    required this.tasks,
    required this.resources,
  });
}
