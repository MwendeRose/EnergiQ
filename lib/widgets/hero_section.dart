// ignore_for_file: use_super_parameters, unnecessary_underscores, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:smart_app/screens/login_page.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _badgeFade;
  late Animation<Offset> _badgeSlide;

  late Animation<double> _headlineFade;
  late Animation<Offset> _headlineSlide;

  late Animation<double> _subtitleFade;
  late Animation<Offset> _subtitleSlide;

  late Animation<double> _buttonsFade;
  late Animation<Offset> _buttonsSlide;

  late Animation<double> _statsFade;
  late Animation<Offset> _statsSlide;

  static const Color goldDeep   = Color(0xFFE89A00);
  static const Color goldBright = Color(0xFFFFD040);
  static const Color goldBorder = Color(0xFFF5C840);
  static const Color goldText   = Color(0xFF6B3D00); // darker gold text
  static const Color inkDark    = Color(0xFF0D0900); // near-black
  static const Color inkMuted   = Color(0xFF3D2E00); // much darker muted

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _badgeFade     = _fade(0.00, 0.25);
    _badgeSlide    = _slide(0.00, 0.25);

    _headlineFade  = _fade(0.15, 0.42);
    _headlineSlide = _slide(0.15, 0.42);

    _subtitleFade  = _fade(0.30, 0.57);
    _subtitleSlide = _slide(0.30, 0.57);

    _buttonsFade   = _fade(0.45, 0.72);
    _buttonsSlide  = _slide(0.45, 0.72);

    _statsFade     = _fade(0.60, 0.90);
    _statsSlide    = _slide(0.60, 0.90);

    _controller.forward();
  }

  Animation<double> _fade(double begin, double end) => CurvedAnimation(
        parent: _controller,
        curve: Interval(begin, end, curve: Curves.easeOut),
      );

  Animation<Offset> _slide(double begin, double end) => Tween<Offset>(
        begin: const Offset(0, 0.18),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(begin, end, curve: Curves.easeOutCubic),
      ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _animated({
    required Animation<double> fade,
    required Animation<Offset> slide,
    required Widget child,
  }) {
    return FadeTransition(
      opacity: fade,
      child: SlideTransition(position: slide, child: child),
    );
  }

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

        // ── Badge ─────────────────────────────────────────
        _animated(
          fade: _badgeFade,
          slide: _badgeSlide,
          child: Container(
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
                _PulseDot(color: goldDeep),
                const SizedBox(width: 8),
                const Text(
                  'Smart Meter Capture & Monitoring',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800, // bolder
                    color: goldText,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 28),

        // ── Headline ──────────────────────────────────────
        _animated(
          fade: _headlineFade,
          slide: _headlineSlide,
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.w900, // bolder
                color: inkDark,
                height: 1.12,
                letterSpacing: -0.5,
              ),
              children: [
                const TextSpan(text: 'Capture meters,\n'),
                TextSpan(
                  text: 'monitor usage',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    foreground: Paint()
                      ..shader = const LinearGradient(
                        colors: [goldDeep, goldBright],
                      ).createShader(const Rect.fromLTWH(0, 0, 300, 60)),
                  ),
                ),
                const TextSpan(text: ' instantly.'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        // ── Subtitle ──────────────────────────────────────
        _animated(
          fade: _subtitleFade,
          slide: _subtitleSlide,
          child: const Text(
            'Log and track smart meter readings across multiple sites. Get instant visibility into consumption data, detect anomalies early, and keep your records accurate — all from your phone.',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF2C1A00), // much darker
              height: 1.7,
              fontWeight: FontWeight.w600, // bolder
            ),
          ),
        ),
        const SizedBox(height: 32),

        // ── Buttons ───────────────────────────────────────
        _animated(
          fade: _buttonsFade,
          slide: _buttonsSlide,
          child: Row(
            children: [
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
                      pageBuilder: (_, __, ___) => const LoginPage(),
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
                    'Start Capturing',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800, // bolder
                      color: Colors.white,
                      letterSpacing: 0.1,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
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
                  'See How It Works',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700, // bolder
                    color: Color(0xFF0D0900), // explicitly dark
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 44),

        // ── Stats ─────────────────────────────────────────
        _animated(
          fade: _statsFade,
          slide: _statsSlide,
          child: Row(
            children: [
              _buildStat('10K+', 'Meters Tracked'),
              const SizedBox(width: 48),
              _buildStat('99.9%', 'Read Accuracy'),
              const SizedBox(width: 48),
              _buildStat('Real-time', 'Data Sync'),
            ],
          ),
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
            fontSize: 24,
            fontWeight: FontWeight.w900, // bolder
            color: inkDark,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: inkMuted, // now much darker (0xFF3D2E00)
            fontWeight: FontWeight.w700, // bolder
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
              'How Smart Meters App Works',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900, // bolder
                color: Color(0xFF0D0900), // near-black
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 20),
            _learnMoreItem(
              icon: Icons.qr_code_scanner_rounded,
              title: 'Scan & Capture Readings',
              desc: 'Quickly log meter readings by scanning or entering values manually on-site.',
            ),
            _learnMoreItem(
              icon: Icons.bar_chart_rounded,
              title: 'Monitor Consumption',
              desc: 'View usage trends and consumption history across all registered meters.',
            ),
            _learnMoreItem(
              icon: Icons.location_on_rounded,
              title: 'Multi-Site Management',
              desc: 'Manage meters across multiple locations from a single dashboard.',
            ),
            _learnMoreItem(
              icon: Icons.warning_amber_rounded,
              title: 'Anomaly Alerts',
              desc: 'Get notified instantly when a reading falls outside expected thresholds.',
            ),
            const SizedBox(height: 24),
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
                  'Start Capturing',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800, // bolder
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
                        fontWeight: FontWeight.w800, // bolder
                        color: Color(0xFF0D0900))),  // near-black
                const SizedBox(height: 2),
                Text(desc,
                    style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF3D2E00), // much darker
                        fontWeight: FontWeight.w500, // bolder
                        height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Pulsing dot ───────────────────────────────────────────────
class _PulseDot extends StatefulWidget {
  final Color color;
  const _PulseDot({required this.color});

  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulse;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _scale = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _pulse, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: widget.color.withOpacity(0.4),
              blurRadius: 6,
              spreadRadius: 2,
            ),
          ],
        ),
      ),
    );
  }
}