// ignore_for_file: use_super_parameters, unnecessary_underscores, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:smart_app/screens/login_page.dart'; // adjust import path as needed

class HeroSection extends StatelessWidget {
  const HeroSection({Key? key}) : super(key: key);

  static const Color goldDeep   = Color(0xFFE89A00);
  static const Color goldBright = Color(0xFFFFD040);
  static const Color goldBg     = Color(0xFFFFF3CC);
  static const Color goldBorder = Color(0xFFF5C840);
  static const Color goldText   = Color(0xFF8A5A00);
  static const Color inkDark    = Color(0xFF1A1200);
  static const Color inkMuted   = Color(0xFF9A8560);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFFBF0), Color(0xFFFFF8DC)],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFF3CC), Color(0xFFFFE68A)],
            ),
            border: Border.all(color: goldBorder, width: 1.5),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: goldBorder.withOpacity(0.25),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: goldDeep,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: goldDeep.withOpacity(0.3),
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Smart Energy Management',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: goldText,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // Headline
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.w800,
              color: inkDark,
              height: 1.12,
              letterSpacing: -0.5,
            ),
            children: [
              const TextSpan(text: 'Monitor your energy,\n'),
              TextSpan(
                text: 'save money',
                style: TextStyle(
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: [goldDeep, goldBright],
                    ).createShader(const Rect.fromLTWH(0, 0, 300, 60)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Subtitle
        const Text(
          'Get real-time insights into your energy consumption and discover smart ways to reduce costs while helping the environment.',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF6B5E3A),
            height: 1.7,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 32),

        // Buttons
        Row(
          children: [
            // Get Started Free → LoginPage
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [goldDeep, goldBright],
                ),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: goldDeep.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 400),
                    // ignore: unnecessary_underscores
                    pageBuilder: (_, __, ___) => const LoginPage(),
                    // ignore: unnecessary_underscores
                    transitionsBuilder: (_, anim, __, child) =>
                        FadeTransition(opacity: anim, child: child),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'Get Started Free',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.1,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Learn More → scrolls to features or opens a modal
            OutlinedButton(
              onPressed: () => _showLearnMore(context),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: inkDark,
                side: const BorderSide(color: Color(0xFFF0D080), width: 2),
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 2,
                shadowColor: Colors.black12,
              ),
              child: const Text(
                'Learn More',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 44),

        // Stats
        Row(
          children: [
            _buildStat('50K+', 'Active Users'),
            const SizedBox(width: 48),
            _buildStat('\$2M+', 'Saved Annually'),
            const SizedBox(width: 48),
            _buildStat('24/7', 'Monitoring'),
          ],
        ),
      ],
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: inkDark,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: inkMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _showLearnMore(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 36),
        decoration: const BoxDecoration(
          color: Color(0xFFFFFBF0),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFF0D080),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Why EnergyIQ?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1200),
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 20),
            _learnMoreItem(
              icon: Icons.bolt_rounded,
              title: 'Real-time monitoring',
              desc: 'Track your energy usage live across all rooms and devices.',
            ),
            _learnMoreItem(
              icon: Icons.savings_rounded,
              title: 'Smart savings',
              desc: 'AI-powered tips that help you cut bills by up to 30%.',
            ),
            _learnMoreItem(
              icon: Icons.eco_rounded,
              title: 'Eco-friendly',
              desc: 'Reduce your carbon footprint with actionable green insights.',
            ),
            _learnMoreItem(
              icon: Icons.notifications_active_rounded,
              title: 'Instant alerts',
              desc: 'Get notified when usage spikes or anomalies are detected.',
            ),
            const SizedBox(height: 24),
            // CTA inside sheet
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE89A00), Color(0xFFFFD040)],
                ),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE89A00).withOpacity(0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 400),
                      pageBuilder: (_, __, ___) => const LoginPage(),
                      transitionsBuilder: (_, anim, __, child) =>
                          FadeTransition(opacity: anim, child: child),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'Get Started Free',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _learnMoreItem({
    required IconData icon,
    required String title,
    required String desc,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFF3CC), Color(0xFFFFE68A)],
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFF5C840), width: 1.5),
            ),
            child: Icon(icon, color: const Color(0xFFE89A00), size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1200))),
                const SizedBox(height: 2),
                Text(desc,
                    style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF9A8560),
                        height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}