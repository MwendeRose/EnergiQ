// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F5F9),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Active Alerts',
                        style: TextStyle(
                          color: Color(0xFF0F0F1A),
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1.0,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF3B3B),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 7),
                          const Text(
                            '3 alerts require your attention',
                            style: TextStyle(
                              color: Color(0xFF6A6A8A),
                              fontSize: 13,
                              letterSpacing: 0.1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF3B3B).withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFFF3B3B).withOpacity(0.20)),
                  ),
                  child: const Text(
                    '3 ACTIVE',
                    style: TextStyle(
                      color: Color(0xFFFF3B3B),
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // ── Summary Pills ────────────────────────────────────────────
            Row(
              children: [
                _SeverityPill(label: 'Critical', count: 1, color: const Color(0xFFE85D00)),
                const SizedBox(width: 7),
                _SeverityPill(label: 'Warning', count: 1, color: const Color(0xFFD4A000)),
                const SizedBox(width: 7),
                _SeverityPill(label: 'Info', count: 1, color: const Color(0xFF0098B0)),
              ],
            ),

            const SizedBox(height: 22),

            // ── Cards ────────────────────────────────────────────────────
            _AlertCard(
              severity: AlertSeverity.critical,
              title: 'Continuous Night Flow Detected',
              time: 'Today, 2:14 AM',
              description:
                  'Uninterrupted water flow detected between 12:00 AM and 5:00 AM '
                  'for 3 consecutive nights — hours when usage should be near zero.',
              stats: const [
                _Stat('Flow Rate', '4.2 L/min'),
                _Stat('Daily Loss', '128 L'),
                _Stat('Extra Cost', 'KES 45/d'),
                _Stat('Duration', '3h 12m'),
              ],
              recommendation:
                  'Check all toilets for running cisterns, inspect outdoor taps '
                  'and hose bibs after dark, and read your main meter twice '
                  '(1 hr apart, no usage) to confirm a leak.',
              causes: const [
                'Leaking toilet cistern — High likelihood',
                'Open outdoor tap or hose bib — Medium',
                'Underground pipe leak — Medium',
                'Faulty float valve — Low',
              ],
            ),

            const SizedBox(height: 12),

            _AlertCard(
              severity: AlertSeverity.warning,
              title: 'Pump Pressure Drop',
              time: 'Today, 6:40 AM',
              description:
                  'Borehole pump pressure has fallen to 2.8 bar — '
                  '0.7 bar below the minimum safe threshold of 3.5 bar.',
              stats: const [
                _Stat('Current', '2.8 bar'),
                _Stat('Min Safe', '3.5 bar'),
                _Stat('Deficit', '-0.7 bar'),
                _Stat('Pump Age', '3.2 yrs'),
              ],
              recommendation:
                  'Inspect the intake filter for debris. Check the pump control panel '
                  'for error codes. Schedule a full pump service if pressure does not recover within 24 hours.',
              causes: const [
                'Clogged intake filter — High likelihood',
                'Pump impeller wear — Medium',
                'Air lock in suction line — Medium',
                'Failing motor windings — Low',
              ],
            ),

            const SizedBox(height: 12),

            _AlertCard(
              severity: AlertSeverity.info,
              title: 'Monthly Usage Limit at 85%',
              time: 'Yesterday, 11:00 PM',
              description:
                  'You have used 12,750 L of your 15,000 L monthly allocation. '
                  'At 562 L/day average, the limit will be exceeded before month end.',
              stats: const [
                _Stat('Used', '12,750 L'),
                _Stat('Limit', '15,000 L'),
                _Stat('Remaining', '2,250 L'),
                _Stat('Days Left', '~4 days'),
              ],
              recommendation:
                  'Review sub-meter data to identify the highest-consuming zones. '
                  'Temporarily suspend garden irrigation and non-essential uses.',
              causes: const [
                'Garden irrigation running daily — Review schedule',
                'High usage in Block A — Check sub-meter',
                'Possible slow leak contributing — Monitor overnight',
              ],
            ),

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}

/* ── Severity Pill ── */

class _SeverityPill extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  const _SeverityPill({required this.label, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.09),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withOpacity(0.22)),
      ),
      child: Text(
        '$count $label',
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

/* ── Severity Enum ── */

enum AlertSeverity { critical, warning, info }

/* ── Stat Data ── */

class _Stat {
  final String label;
  final String value;
  const _Stat(this.label, this.value);
}

/* ── Alert Card ── */

class _AlertCard extends StatelessWidget {
  final AlertSeverity severity;
  final String title, time, description, recommendation;
  final List<_Stat> stats;
  final List<String> causes;

  const _AlertCard({
    required this.severity,
    required this.title,
    required this.time,
    required this.description,
    required this.stats,
    required this.recommendation,
    required this.causes,
  });

  Color get _accent => switch (severity) {
        AlertSeverity.critical => const Color(0xFFE85D00),
        AlertSeverity.warning  => const Color(0xFFD4A000),
        AlertSeverity.info     => const Color(0xFF0098B0),
      };

  Color get _bgLight => switch (severity) {
        AlertSeverity.critical => const Color(0xFFFFF6F0),
        AlertSeverity.warning  => const Color(0xFFFFFBE8),
        AlertSeverity.info     => const Color(0xFFE8F8FB),
      };

  String get _badge => switch (severity) {
        AlertSeverity.critical => 'CRITICAL',
        AlertSeverity.warning  => 'WARNING',
        AlertSeverity.info     => 'INFO',
      };

  String get _tagline => switch (severity) {
        AlertSeverity.critical => 'Immediate action required',
        AlertSeverity.warning  => 'Attention needed soon',
        AlertSeverity.info     => 'Monitor and plan ahead',
      };

  void _openDetail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => _AlertDetailPage(
        severity: severity,
        title: title,
        time: time,
        description: description,
        stats: stats,
        recommendation: recommendation,
        causes: causes,
        accent: _accent,
        bgLight: _bgLight,
        badge: _badge,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openDetail(context),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _accent.withOpacity(0.18)),
          boxShadow: [
            BoxShadow(
              color: _accent.withOpacity(0.07),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top band ─────────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
              decoration: BoxDecoration(
                color: _bgLight,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
              ),
              child: Row(
                children: [
                  // Left: badge + tagline
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 3),
                              decoration: BoxDecoration(
                                color: _accent,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                _badge,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              time,
                              style: const TextStyle(
                                color: Color(0xFF9090A8),
                                fontSize: 10.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          _tagline,
                          style: TextStyle(
                            color: _accent,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Right: chevron
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: _accent.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Text(
                      '›',
                      style: TextStyle(
                        color: _accent,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Title + Description ───────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 13, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF0F0F1A),
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.4,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Color(0xFF5A5A7A),
                      fontSize: 12.5,
                      height: 1.55,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ── Stats Row ─────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: List.generate(stats.length, (i) {
                  final s = stats[i];
                  final isLast = i == stats.length - 1;
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: isLast ? 0 : 7),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        color: _bgLight,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: _accent.withOpacity(0.14)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.value,
                            style: TextStyle(
                              color: _accent,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            s.label,
                            style: const TextStyle(
                              color: Color(0xFF9898B0),
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),

            // ── Divider ───────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
              child: Divider(color: const Color(0xFFEEEEF5), thickness: 1, height: 1),
            ),

            // ── Footer Actions ────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 13),
              child: Row(
                children: [
                  // View Details text link
                  GestureDetector(
                    onTap: () => _openDetail(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 11, vertical: 7),
                      decoration: BoxDecoration(
                        color: _accent.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(color: _accent.withOpacity(0.18)),
                      ),
                      child: Text(
                        'View Details',
                        style: TextStyle(
                          color: _accent,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Dismiss
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF8888A0),
                      side: const BorderSide(color: Color(0xFFDDDDEE)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9)),
                      textStyle: const TextStyle(fontSize: 11),
                    ),
                    child: const Text('Dismiss'),
                  ),
                  const SizedBox(width: 7),
                  // Resolve
                  FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: _accent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9)),
                      textStyle: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w700),
                    ),
                    child: const Text('Resolve'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ─────────────────────────── Full Detail Page ──────────────────────────────── */

class _AlertDetailPage extends StatelessWidget {
  final AlertSeverity severity;
  final String title, time, description, recommendation, badge;
  final List<_Stat> stats;
  final List<String> causes;
  final Color accent, bgLight;

  const _AlertDetailPage({
    required this.severity,
    required this.title,
    required this.time,
    required this.description,
    required this.stats,
    required this.recommendation,
    required this.causes,
    required this.accent,
    required this.bgLight,
    required this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 16, color: Color(0xFF1A1A2E)),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Alert Details',
          style: TextStyle(
            color: Color(0xFF0F0F1A),
            fontSize: 15,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 14),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: accent.withOpacity(0.09),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: accent.withOpacity(0.22)),
            ),
            child: Text(
              'ACTIVE',
              style: TextStyle(
                color: accent,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Hero ─────────────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: accent.withOpacity(0.30),
                    blurRadius: 22,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.22),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          badge,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        time,
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.7,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12.5,
                      height: 1.55,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Stats Grid ───────────────────────────────────────────────
            Row(
              children: List.generate(stats.length, (i) {
                final s = stats[i];
                final isLast = i == stats.length - 1;
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: isLast ? 0 : 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: accent.withOpacity(0.13)),
                      boxShadow: [
                        BoxShadow(
                          color: accent.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s.value,
                          style: TextStyle(
                            color: accent,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          s.label,
                          style: const TextStyle(
                            color: Color(0xFF9898B0),
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 14),

            // ── Possible Causes ──────────────────────────────────────────
            _DetailSection(
              title: 'POSSIBLE CAUSES',
              accent: accent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: causes.asMap().entries.map((e) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: accent.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            '${e.key + 1}',
                            style: TextStyle(
                              color: accent,
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            e.value,
                            style: const TextStyle(
                              color: Color(0xFF4A4A6A),
                              fontSize: 12.5,
                              height: 1.45,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 12),

            // ── What To Do ───────────────────────────────────────────────
            _DetailSection(
              title: 'WHAT TO DO',
              accent: accent,
              child: Text(
                recommendation,
                style: const TextStyle(
                  color: Color(0xFF4A4A6A),
                  fontSize: 12.5,
                  height: 1.6,
                ),
              ),
            ),

            const SizedBox(height: 22),

            // ── Actions ──────────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: accent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13)),
                  textStyle: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w800),
                ),
                child: const Text('Take Action'),
              ),
            ),
            const SizedBox(height: 9),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF5A5A7A),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: const BorderSide(color: Color(0xFFDDDDEE)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13)),
                      textStyle: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    child: const Text('Snooze 24h'),
                  ),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.maybePop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF3BAD60),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: const BorderSide(color: Color(0xFF3BAD60)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13)),
                      textStyle: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    child: const Text('Mark Resolved'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

/* ── Detail Section ── */

class _DetailSection extends StatelessWidget {
  final String title;
  final Color accent;
  final Widget child;

  const _DetailSection({
    required this.title,
    required this.accent,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withOpacity(0.13)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: accent,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}