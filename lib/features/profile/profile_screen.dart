import 'package:flutter/material.dart';
import 'dart:math' as math;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late AnimationController _streakController;

  @override
  void initState() {
    super.initState();
    _streakController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _streakController.dispose();
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
                        _buildProfileHeader(),
                        const SizedBox(height: 32),
                        _buildStatsGrid(),
                        const SizedBox(height: 32),
                        _buildFocusDomains(),
                        const SizedBox(height: 32),
                        _buildAccountPreferences(),
                        const SizedBox(height: 32),
                        _buildSecuritySection(),
                        const SizedBox(height: 24),
                        _buildLogoutButton(),
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
              color: Color(0xFFD0BCFF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Center(
          child: SizedBox(
            width: 96,
            height: 96,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFD0BCFF), Color(0xFF89CEFF)],
                    ),
                  ),
                  padding: const EdgeInsets.all(2),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF131314),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuAiuGNLDKhOq3YGQkJ7lhUkLhfi61ZtKfIO1wS0F94Gf-SAhuqP-GRw2mKIFfIgXnHOFX1YhY2XXDEZZ4LtbitiYzFA6xTPLnoR_N9Rvg6ySCK_ovCtP3MOHXEvyaZoLEeIP8MYgPi3BAoR9wYBSR3WKbX4mFW5YsT3n3KV6o4ncz9baIdiq3jurGHd7Onvg8ZMr32ZDSHDGHdiQNKzk7nvECycX8KBlgwwvH0HTkB8UDQl5AjOkoJLkC7Kj9Ac6IuUqn52vCm4BHTb',
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF4EDEA3),
                      border: Border(
                        left: BorderSide(color: Color(0xFF131314), width: 2),
                        top: BorderSide(color: Color(0xFF131314), width: 2),
                      ),
                    ),
                    child: const Icon(
                      Icons.verified,
                      color: Color(0xFF002113),
                      size: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Alex Sterling',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Color(0xFFE5E2E3),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'ELITE PERFORMER • LVL 42',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFFD0BCFF),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard('1,284', 'Focus Hours', const Color(0xFF89CEFF)),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard('158', 'Completed', const Color(0xFFD0BCFF)),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: _buildStreakCard(),
        ),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, Color color) {
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.5,
              color: Color(0xFF958EA0),
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
            const Color(0xFFD0BCFF).withValues(alpha: 0.1),
            const Color(0xFFFFFFFF).withValues(alpha: 0.01),
          ],
        ),
        border: Border.all(
          color: const Color(0xFFFFFFFF).withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: _streakController,
            builder: (context, child) {
              return SizedBox(
                width: 64,
                height: 64,
                child: CustomPaint(
                  painter: _StreakProgressPainter(
                    progress: _streakController.value * 0.82,
                    glowColor: const Color(0xFF4EDEA3),
                  ),
                  child: const Center(
                    child: Text(
                      '82%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFE5E2E3),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Daily Streak',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFE5E2E3),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '24 Days Active',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF4EDEA3),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFocusDomains() {
    final domains = [
      {'icon': Icons.fitness_center, 'name': 'Physical Elite', 'color': const Color(0xFFD0BCFF)},
      {'icon': Icons.terminal, 'name': 'Deep Work', 'color': const Color(0xFF89CEFF)},
      {'icon': Icons.psychology, 'name': 'Mindset', 'color': const Color(0xFF4EDEA3)},
      {'icon': Icons.account_balance_wallet, 'name': 'Capital', 'color': const Color(0xFFFFB4AB)},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Focus Domains',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFFE5E2E3),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: domains.map((domain) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                  color: (domain['color'] as Color).withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    domain['icon'] as IconData,
                    color: domain['color'] as Color,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    domain['name'] as String,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFE5E2E3),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAccountPreferences() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'ACCOUNT & PREFERENCES',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.5,
              color: Color(0xFF958EA0),
            ),
          ),
        ),
        const SizedBox(height: 12),
        _buildMenuItem(
          Icons.person_outline,
          'Personal Information',
          const Color(0xFFD0BCFF),
        ),
        const SizedBox(height: 8),
        _buildMenuItem(
          Icons.settings,
          'App Settings',
          const Color(0xFF89CEFF),
        ),
      ],
    );
  }

  Widget _buildSecuritySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'SECURITY',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.5,
              color: Color(0xFF958EA0),
            ),
          ),
        ),
        const SizedBox(height: 12),
        _buildMenuItem(
          Icons.lock_open,
          'Privacy & Bio-auth',
          const Color(0xFF4EDEA3),
        ),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: color.withValues(alpha: 0.1),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFFE5E2E3),
              ),
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: const Color(0xFF958EA0),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
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
            color: const Color(0xFFFFB4AB).withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.logout,
              color: Color(0xFFFFB4AB),
              size: 20,
            ),
            const SizedBox(width: 8),
            const Text(
              'LOG OUT SYSTEM',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5,
                color: Color(0xFFFFB4AB),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StreakProgressPainter extends CustomPainter {
  final double progress;
  final Color glowColor;

  _StreakProgressPainter({required this.progress, required this.glowColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;
    final strokeWidth = 3.0;

    final backgroundPaint = Paint()
      ..color = const Color(0xFFFFFFFF).withValues(alpha: 0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, backgroundPaint);

    final progressPaint = Paint()
      ..color = glowColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_StreakProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
