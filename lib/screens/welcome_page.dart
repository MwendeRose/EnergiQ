// lib/screens/welcome_page.dart
// ignore_for_file: deprecated_member_use, unnecessary_underscores, unused_field

import 'package:flutter/material.dart';
import 'login_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeIn;
  late final Animation<Offset> _slideIn;

  // ── Colour palette ────────────────────────────────────────
  static const kBg         = Color(0xFFFDF8EC);
  static const kNavBg      = Color(0xFFFDF8EC);
  static const kBrand      = Color(0xFF1B4FD8);
  static const kAmber      = Color(0xFFFFAA00);
  static const kText       = Color(0xFF111827);
  static const kSubtext    = Color(0xFF6B7280);
  static const kWhite      = Color(0xFFFFFFFF);
  static const kBorder     = Color(0xFFE5E7EB);
  static const kCardBg     = Color(0xFFFFFFFF);
  static const kFooterBg   = Color(0xFF1A1A1A);
  static const kIconBg     = Color(0xFF1B4FD8);
  static const kTagBg      = Color(0xFFFFF3CD);
  static const kTagText    = Color(0xFF92600A);
  static const kCheckGreen = Color(0xFF16A34A);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideIn = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToLogin({int mode = 0}) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 420),
        pageBuilder: (_, __, ___) => const LoginPage(),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // BUILD
  // ════════════════════════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: FadeTransition(
        opacity: _fadeIn,
        child: SlideTransition(
          position: _slideIn,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildNavBar(),
                _buildHeroSection(),
                _buildFeaturesSection(),
                _buildTrustSection(),
                _buildCtaFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Nav Bar ───────────────────────────────────────────────

  Widget _buildNavBar() {
    return Container(
      color: kNavBg,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Row(
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: kAmber,
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: const Text(
                  '>',
                  style: TextStyle(
                    color: kFooterBg,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Snapp Africa',
                style: TextStyle(
                  color: kText,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => _goToLogin(mode: 0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: kText,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: kWhite,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward, color: kWhite, size: 13),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Hero ──────────────────────────────────────────────────

  Widget _buildHeroSection() {
    return Container(
      color: kBg,
      padding: const EdgeInsets.fromLTRB(24, 36, 24, 40),
      child: _buildHeroText(),
    );
  }

  Widget _buildHeroText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: kTagBg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kAmber.withOpacity(0.4)),
          ),
          child: const Text(
            'Transform Your Energy Management',
            style: TextStyle(
              color: kTagText,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Monitor Your Energy,',
          style: TextStyle(
            color: kText,
            fontSize: 30,
            fontWeight: FontWeight.w900,
            height: 1.1,
            letterSpacing: -0.5,
          ),
        ),
        const Text(
          'Save Money',
          style: TextStyle(
            color: kAmber,
            fontSize: 30,
            fontWeight: FontWeight.w900,
            height: 1.1,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Take control of your energy consumption with our intelligent smart meter '
          'platform. Track, analyze, and optimize your usage in real-time.',
          style: TextStyle(color: kSubtext, fontSize: 13, height: 1.65),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _FilledBtn(
              label: 'Get Started',
              onPressed: () => _goToLogin(mode: 1),
              icon: Icons.arrow_forward,
            ),
            _OutlineBtn(
              label: 'Login',
              onPressed: () => _goToLogin(mode: 0),
            ),
          ],
        ),
        const SizedBox(height: 28),
        Row(
          children: const [
            _StatChip(value: '50K+', label: 'Active Users'),
            SizedBox(width: 20),
            _StatDivider(),
            SizedBox(width: 20),
            _StatChip(value: '30%', label: 'Avg. Savings'),
            SizedBox(width: 20),
            _StatDivider(),
            SizedBox(width: 20),
            _StatChip(value: '24/7', label: 'Monitoring'),
          ],
        ),
      ],
    );
  }

  // ── Features ──────────────────────────────────────────────

  Widget _buildFeaturesSection() {
    final features = [
      _FeatureData(
        icon: Icons.bolt_outlined,
        title: 'Real-Time Monitoring',
        desc: 'Track your energy consumption in real time and make informed decisions',
      ),
      _FeatureData(
        icon: Icons.bar_chart_rounded,
        title: 'Detailed Analytics',
        desc: 'Get comprehensive insights into your usage patterns and trends',
      ),
      _FeatureData(
        icon: Icons.savings_outlined,
        title: 'Cost Savings',
        desc: 'Identify opportunities to reduce your energy bills and save money',
      ),
      _FeatureData(
        icon: Icons.notifications_outlined,
        title: 'Smart Alerts',
        desc: 'Receive notifications about unusual consumption and peak hours',
      ),
    ];

    return Container(
      color: kBg,
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 44),
      child: Column(
        children: [
          const SizedBox(height: 8),
          const Text(
            'Everything You Need to Save Energy',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kText,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Powerful features designed to help you understand and optimize your energy consumption',
            textAlign: TextAlign.center,
            style: TextStyle(color: kSubtext, fontSize: 12.5, height: 1.6),
          ),
          const SizedBox(height: 28),
          LayoutBuilder(builder: (context, constraints) {
            final isWide = constraints.maxWidth > 520;
            if (isWide) {
              return Row(
                children: features
                    .map((f) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: _FeatureCard(data: f),
                          ),
                        ))
                    .toList(),
              );
            }
            return GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.95,
              children: features.map((f) => _FeatureCard(data: f)).toList(),
            );
          }),
        ],
      ),
    );
  }

  // ── Trust ─────────────────────────────────────────────────

  Widget _buildTrustSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(28),
      child: _buildTrustText(),
    );
  }

  Widget _buildTrustText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Trusted by Thousands Across Africa',
          style: TextStyle(
            color: kText,
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.3,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Join our community of energy-conscious users who have reduced their consumption '
          'and saved money on their utility bills.',
          style: TextStyle(color: kSubtext, fontSize: 12.5, height: 1.65),
        ),
        const SizedBox(height: 20),
        _BulletPoint(text: 'Easy Setup\nConnect your smart meter in minutes'),
        const SizedBox(height: 12),
        _BulletPoint(text: 'Secure & Private\nYour data is encrypted and protected'),
        const SizedBox(height: 12),
        _BulletPoint(text: 'Expert Support\n24/7 customer service available'),
      ],
    );
  }

  // ── CTA Footer ────────────────────────────────────────────

  Widget _buildCtaFooter() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      color: kFooterBg,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 44),
      child: Column(
        children: [
          const Text(
            'Ready to Start Saving?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kWhite,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Join thousands of users across Africa who are taking control of their energy consumption',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 13, height: 1.6),
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              _FilledBtn(
                label: 'Create Account',
                onPressed: () => _goToLogin(mode: 1),
                icon: Icons.arrow_forward,
                amber: true,
              ),
              _GhostBtn(
                label: 'Learn More',
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ════════════════════════════════════════════════════════════

// ── Stats ─────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  final String value;
  final String label;
  const _StatChip({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value,
            style: const TextStyle(
                color: _WelcomePageState.kText,
                fontSize: 18,
                fontWeight: FontWeight.w900)),
        Text(label,
            style: const TextStyle(
                color: _WelcomePageState.kSubtext, fontSize: 10.5)),
      ],
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 28, color: const Color(0xFFD1D5DB));
  }
}

// ── Feature card ──────────────────────────────────────────

class _FeatureData {
  final IconData icon;
  final String title;
  final String desc;
  const _FeatureData({required this.icon, required this.title, required this.desc});
}

class _FeatureCard extends StatelessWidget {
  final _FeatureData data;
  const _FeatureCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _WelcomePageState.kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _WelcomePageState.kBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _WelcomePageState.kIconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(data.icon, color: Colors.white, size: 18),
          ),
          const SizedBox(height: 12),
          Text(data.title,
              style: const TextStyle(
                  color: _WelcomePageState.kText,
                  fontSize: 13,
                  fontWeight: FontWeight.w800)),
          const SizedBox(height: 5),
          Text(data.desc,
              style: const TextStyle(
                  color: _WelcomePageState.kSubtext,
                  fontSize: 11.5,
                  height: 1.55)),
        ],
      ),
    );
  }
}

// ── Bullet point ──────────────────────────────────────────

class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    final parts = text.split('\n');
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: const BoxDecoration(
            color: _WelcomePageState.kCheckGreen,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 11),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(parts[0],
                  style: const TextStyle(
                      color: _WelcomePageState.kText,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700)),
              if (parts.length > 1)
                Text(parts[1],
                    style: const TextStyle(
                        color: _WelcomePageState.kSubtext, fontSize: 11.5)),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Buttons ───────────────────────────────────────────────

class _FilledBtn extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool amber;
  const _FilledBtn({
    required this.label,
    required this.onPressed,
    this.icon,
    this.amber = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              amber ? _WelcomePageState.kAmber : _WelcomePageState.kText,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          elevation: 0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label,
                style: TextStyle(
                    color: amber
                        ? _WelcomePageState.kFooterBg
                        : _WelcomePageState.kWhite,
                    fontWeight: FontWeight.w700,
                    fontSize: 13)),
            if (icon != null) ...[
              const SizedBox(width: 6),
              Icon(icon,
                  size: 14,
                  color: amber
                      ? _WelcomePageState.kFooterBg
                      : _WelcomePageState.kWhite),
            ]
          ],
        ),
      ),
    );
  }
}

class _OutlineBtn extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const _OutlineBtn({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: _WelcomePageState.kBorder, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        child: Text(label,
            style: const TextStyle(
                color: _WelcomePageState.kText,
                fontWeight: FontWeight.w700,
                fontSize: 13)),
      ),
    );
  }
}

class _GhostBtn extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const _GhostBtn({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF4B5563), width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        child: Text(label,
            style: const TextStyle(
                color: Color(0xFFD1D5DB),
                fontWeight: FontWeight.w700,
                fontSize: 13)),
      ),
    );
  }
}