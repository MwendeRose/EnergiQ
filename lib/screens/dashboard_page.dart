// lib/screens/dashboard_page.dart
// ignore_for_file: deprecated_member_use, unused_element, unnecessary_underscores, use_build_context_synchronously

import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/borehole_system_card.dart';
import '../main.dart'; // for replayWelcome()
import 'alerts_page.dart';
import 'analytics.dart';
import 'settings.dart';
import 'home_screen.dart'; // AppColors, HomeContentPage

// ─── Greeting helper ───────────────────────────────────────────
String _greeting() {
  final h = DateTime.now().hour;
  if (h < 12) return 'Good Morning';
  if (h < 17) return 'Good Afternoon';
  return 'Good Evening';
}

// ════════════════════════════════════════════════════════════════
//  DASHBOARD PAGE
// ════════════════════════════════════════════════════════════════
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _sideIndex = 0;
  final _pumpState = PumpStateNotifier(initiallyRunning: true);

  @override
  void dispose() {
    _pumpState.dispose();
    super.dispose();
  }

  // 0 = Dashboard overview
  // 1 = Home
  // 2 = Alerts
  // 3 = Analytics
  // 4 = Settings
  // 5 = Profile
  Widget _body() {
    switch (_sideIndex) {
      case 1:
        return HomeContentPage(
          pumpState: _pumpState,
          onGoToAlerts: () => setState(() => _sideIndex = 2),
        );
      case 2:
        return const AlertsPage();
      case 3:
        return const AnalyticsPage();
      case 4:
        return const SettingsPage();
      case 5:
        return const _ProfileTab();
      default:
        return OverviewPage(
          onGoToAlerts: () => setState(() => _sideIndex = 2),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Sidebar ─────────────────────────────────────────
            _DashSidebar(
              selected: _sideIndex,
              onSelect: (i) => setState(() => _sideIndex = i),
            ),

            // ── Main content ────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ① Persistent title bar — always visible
                  const _TitleBar(),

                  // ② Page body
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Opacity(
                            opacity: 0.03,
                            child: Image.asset(
                              'assets/meter.png',
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const SizedBox.shrink(),
                            ),
                          ),
                        ),
                        _body(),
                      ],
                    ),
                  ),

                  // ③ Persistent footer — always visible
                  const _AppFooter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
//  PERSISTENT TITLE BAR
// ════════════════════════════════════════════════════════════════
class _TitleBar extends StatelessWidget {
  const _TitleBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1D4ED8), Color(0xFF2563EB), Color(0xFF3B82F6)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x331D4ED8),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Smart Meter App',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.2,
            ),
          ),
          SizedBox(height: 2),
          Text(
            'Borehole Management System',
            style: TextStyle(
              color: Color(0xFFBAE6FD),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
//  SIDEBAR
// ════════════════════════════════════════════════════════════════
class _DashSidebar extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelect;
  const _DashSidebar({required this.selected, required this.onSelect});

  static const _bg      = Color(0xFFEFF6FF);
  static const _border  = Color(0xFFBFD7F5);
  static const _iconOff = Color(0xFF3B82F6);
  static const _lblOff  = Color(0xFF1E40AF);
  static const _selBg   = Color(0xFF1D4ED8);
  static const _selFg   = Color(0xFFFFFFFF);
  static const _hover   = Color(0xFFBFD7F5);

  static const _items = [
    _NavEntry(icon: Icons.dashboard_rounded,     label: 'Dashboard', idx: 0),
    _NavEntry(icon: Icons.home_rounded,          label: 'Home',      idx: 1),
    _NavEntry(icon: Icons.notifications_rounded, label: 'Alerts',    idx: 2, badge: true),
    _NavEntry(icon: Icons.bar_chart_rounded,     label: 'Analytics', idx: 3),
    _NavEntry(icon: Icons.settings_rounded,      label: 'Settings',  idx: 4),
    _NavEntry(icon: Icons.person_rounded,        label: 'Profile',   idx: 5),
  ];

  @override
  Widget build(BuildContext context) {
    final user     = AuthService.instance.user;
    final initials = user?.initials ?? '?';
    final name     = user?.name     ?? 'User';
    final role     = user?.role     ?? 'Manager';

    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: _bg,
        border: const Border(right: BorderSide(color: _border, width: 1.5)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1D4ED8).withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(6, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          // ── Logo — white card so logo colours always pop ──────
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(10, 16, 10, 14),
            child: Center(
              child: Container(
                width: 172,
                height: 172,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border:
                      Border.all(color: const Color(0xFFBFD7F5), width: 1.5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A1D4ED8),
                      blurRadius: 14,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/Logo.png',
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                  isAntiAlias: true,
                  errorBuilder: (_, __, ___) => const _SideLogoFallback(),
                ),
              ),
            ),
          ),

          Container(height: 1.5, color: _border),
          const SizedBox(height: 6),

          // ── Nav items ─────────────────────────────────────────
          Expanded(
            child: ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              children: _items.map((item) {
                final active = selected == item.idx;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: () => onSelect(item.idx),
                      borderRadius: BorderRadius.circular(12),
                      hoverColor: _hover,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 170),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                        decoration: BoxDecoration(
                          color: active ? _selBg : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: active
                              ? [
                                  BoxShadow(
                                    color: _selBg.withOpacity(0.28),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : [],
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 26,
                              child: item.badge
                                  ? Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Icon(item.icon,
                                            size: 22,
                                            color:
                                                active ? _selFg : _iconOff),
                                        Positioned(
                                          top: -3,
                                          right: -4,
                                          child: Container(
                                            width: 9,
                                            height: 9,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFDC2626),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Icon(item.icon,
                                      size: 22,
                                      color: active ? _selFg : _iconOff),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                item.label,
                                style: TextStyle(
                                  color: active ? _selFg : _lblOff,
                                  fontSize: 13,
                                  fontWeight: active
                                      ? FontWeight.w700
                                      : FontWeight.w600,
                                  letterSpacing: 0.1,
                                ),
                              ),
                            ),
                            if (item.badge)
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 170),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 2),
                                decoration: BoxDecoration(
                                  color: active
                                      ? Colors.white.withOpacity(0.25)
                                      : const Color(0xFFDC2626),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  '3',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // ── Divider ───────────────────────────────────────────
          Container(
            height: 1.5,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: _border,
          ),
          const SizedBox(height: 10),

          // ── User pill ─────────────────────────────────────────
          ListenableBuilder(
            listenable: AuthService.instance,
            builder: (_, __) => GestureDetector(
              onTap: () => onSelect(5),
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 14),
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: _selBg.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _border, width: 1.5),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: _selBg,
                      child: Text(
                        initials,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              color: Color(0xFF1E3A8A),
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            role,
                            style: const TextStyle(
                              color: Color(0xFF3B82F6),
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xFF93C5FD),
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Nav entry ─────────────────────────────────────────────────
class _NavEntry {
  final IconData icon;
  final String label;
  final int idx;
  final bool badge;
  const _NavEntry({
    required this.icon,
    required this.label,
    required this.idx,
    this.badge = false,
  });
}

// ─── Logo fallback ─────────────────────────────────────────────
class _SideLogoFallback extends StatelessWidget {
  const _SideLogoFallback();
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '>',
          style: TextStyle(
            color: Color(0xFFFFAA00),
            fontSize: 28,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(width: 2),
        Text(
          'S',
          style: TextStyle(
            color: Color(0xFF1D4ED8),
            fontSize: 26,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
//  OVERVIEW PAGE (index 0)
// ════════════════════════════════════════════════════════════════
class OverviewPage extends StatelessWidget {
  final VoidCallback? onGoToAlerts;
  const OverviewPage({super.key, this.onGoToAlerts});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AuthService.instance,
      builder: (context, _) {
        final firstName =
            AuthService.instance.user?.firstName ?? 'there';
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _GreetingRow(firstName: firstName),
              const SizedBox(height: 28),
              const _DashboardExplainCard(),
            ],
          ),
        );
      },
    );
  }
}

// ════════════════════════════════════════════════════════════════
//  EXPLANATION CARD
// ════════════════════════════════════════════════════════════════
class _DashboardExplainCard extends StatelessWidget {
  const _DashboardExplainCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 26, 22, 30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFBFD7F5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1D4ED8).withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SecTitle('What is the Smart Meter App?'),
          SizedBox(height: 14),
          _P('The Smart Meter App is a comprehensive water management platform built for Kenyan property owners, estate managers, and institutions. It connects your physical water infrastructure — boreholes, storage tanks, municipal supply lines, and individual unit meters — into a single, unified digital dashboard you can access from anywhere, at any time.'),
          SizedBox(height: 12),
          _P('At its core, the system uses IoT-enabled smart meters and sensors that stream readings to a secure backend server every 5 to 15 minutes over GSM, 4G, or RF networks. You always have an up-to-date picture of your water consumption, tank levels, and pump status — without physically visiting the site.'),
          SizedBox(height: 12),
          _P('The app brings together four data sources: the main municipal supply meter, the borehole flow meter, individual sub-meters in each unit or zone, and the tank level sensor — giving you a complete and accurate view of every litre entering, moving through, and leaving your property.'),

          SizedBox(height: 28),
          _HDivider(),
          SizedBox(height: 24),

          _SecTitle('What problems does it solve?'),
          SizedBox(height: 14),
          _P('Many Kenyan properties face three persistent challenges: inaccurate tenant billing, undetected leaks that waste thousands of litres, and the inefficiency of managing borehole pumps manually. Smart Meter App addresses all three simultaneously.'),
          SizedBox(height: 12),
          _P('Sub-meters installed in each apartment or zone capture exact consumption per unit. The app automatically applies the current Nairobi Water rising-block tariff to generate itemised bills landlords can share directly with tenants — eliminating disputes and dramatically reducing billing time.'),
          SizedBox(height: 12),
          _P('For borehole-dependent properties, remote pump control changes everything. The pump can be scheduled to run during off-peak electricity hours, auto-activated when the tank drops below a configurable threshold, and shut down the moment the tank is full or a leak is detected.'),
          SizedBox(height: 12),
          _P('Leak detection works by comparing hourly flow rates against your property\'s baseline. A dripping tap wastes ~34 litres per day; a running toilet up to 400 litres. The system flags anomalies within minutes so you can act before losses become significant.'),

          SizedBox(height: 28),
          _HDivider(),
          SizedBox(height: 24),

          _SecTitle('Who is it built for?'),
          SizedBox(height: 14),
          _P('The app is designed for property managers overseeing residential apartment blocks, commercial complexes, schools, hospitals, and any institution that relies on a mix of municipal supply and private borehole water. It is equally useful for individual homeowners who want visibility into household water use and remote pump control.'),
          SizedBox(height: 12),
          _P('Built with Kenya\'s regulatory environment in mind, the app\'s monthly extraction logs are compatible with WRMA compliance reporting — helping borehole owners stay within their licensed extraction limits without manual record-keeping.'),

          SizedBox(height: 28),
          _HDivider(),
          SizedBox(height: 24),

          _SecTitle('How does the data reach you?'),
          SizedBox(height: 14),
          _P('Each smart meter or sensor sends readings wirelessly to a backend server using GSM (2G) for remote sites with weak signal, 4G LTE for urban properties needing low-latency updates, or RF/LoRa radio mesh where multiple meters communicate locally before forwarding data to the cloud.'),
          SizedBox(height: 12),
          _P('The backend processes and stores every reading, then exposes it through a secure API that powers this dashboard. If connectivity is interrupted, the meters store readings locally and sync automatically when restored — no historical data is ever lost.'),
          SizedBox(height: 12),
          _P('All the information you see — tank level, pump status, today\'s consumption, active alerts, and per-unit billing — is derived from that continuous stream of sensor data. Tap any section in the sidebar to explore meters, alerts, reports, and your account settings.'),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
//  PROFILE TAB (index 5)
// ════════════════════════════════════════════════════════════════
class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AuthService.instance,
      builder: (context, _) {
        final user  = AuthService.instance.user;
        final name  = user?.name  ?? 'User';
        final email = user?.email ?? '';
        final first = (user?.firstName ?? 'U')[0].toUpperCase();

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
          child: Column(
            children: [
              CircleAvatar(
                radius: 44,
                backgroundColor: const Color(0xFF1D4ED8),
                child: Text(
                  first,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                name,
                style: const TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                email,
                style: const TextStyle(
                  color: Color(0xFF475569),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFDBEAFE),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF1D4ED8).withOpacity(0.3),
                  ),
                ),
                child: const Text(
                  'Property Manager',
                  style: TextStyle(
                    color: Color(0xFF1D4ED8),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              ...[
                ['Account Settings',   Icons.manage_accounts_outlined, Color(0xFF1D4ED8)],
                ['Notification Prefs', Icons.notifications_outlined,   Color(0xFF0891B2)],
                ['Team Members',       Icons.group_outlined,            Color(0xFF16A34A)],
                ['Pump Schedules',     Icons.schedule_outlined,         Color(0xFF7C3AED)],
                ['Alert Thresholds',   Icons.tune_rounded,              Color(0xFFEA580C)],
                ['Billing Config',     Icons.receipt_long_outlined,     Color(0xFF0E7A3E)],
                ['Help & Support',     Icons.help_outline_rounded,      Color(0xFF475569)],
                ['About Smart Meter',  Icons.info_outline_rounded,      Color(0xFF475569)],
              ].map(
                (item) => _PRow(
                  label: item[0] as String,
                  icon:  item[1] as IconData,
                  color: item[2] as Color,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    await AuthService.instance.signOut();
                    if (context.mounted) {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/', (r) => false);
                    }
                  },
                  icon: const Icon(Icons.logout_rounded,
                      color: Color(0xFFDC2626), size: 18),
                  label: const Text(
                    'Sign Out',
                    style: TextStyle(
                      color: Color(0xFFDC2626),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(
                        color: Color(0xFFDC2626), width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  const _PRow(
      {required this.label, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFBFD7F5)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Icon(icon, size: 17, color: color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: const Color(0xFF475569).withOpacity(0.4),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
//  SMALL HELPERS
// ════════════════════════════════════════════════════════════════
class _GreetingRow extends StatelessWidget {
  final String firstName;
  const _GreetingRow({required this.firstName});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_greeting()}, $firstName 👋',
                style: const TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 3),
              const Text(
                "Here's an overview of your Smart Meter system.",
                style: TextStyle(
                  color: Color(0xFF475569),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () => replayWelcome(context),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFDBEAFE),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFF1D4ED8).withOpacity(0.25),
              ),
            ),
            child: const Text(
              'Intro',
              style: TextStyle(
                color: Color(0xFF1D4ED8),
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SecTitle extends StatelessWidget {
  final String text;
  const _SecTitle(this.text);
  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(
          color: Color(0xFF0F172A),
          fontSize: 17,
          fontWeight: FontWeight.w900,
          letterSpacing: -0.3,
          height: 1.25,
        ),
      );
}

class _P extends StatelessWidget {
  final String text;
  const _P(this.text);
  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(
          color: Color(0xFF475569),
          fontSize: 14,
          height: 1.75,
        ),
      );
}

class _HDivider extends StatelessWidget {
  const _HDivider();
  @override
  Widget build(BuildContext context) =>
      Container(height: 1, color: const Color(0xFFBFD7F5));
}

// ════════════════════════════════════════════════════════════════
//  PERSISTENT FOOTER — email capture + branding
// ════════════════════════════════════════════════════════════════
class _AppFooter extends StatefulWidget {
  const _AppFooter();
  @override
  State<_AppFooter> createState() => _AppFooterState();
}

class _AppFooterState extends State<_AppFooter> {
  final _emailCtrl = TextEditingController();
  bool _submitted  = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final email = _emailCtrl.text.trim();
    final valid = RegExp(
      r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email);

    if (!valid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address.'),
          backgroundColor: Color(0xFFDC2626),
        ),
      );
      return;
    }
    setState(() => _submitted = true);
    // 
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF1E3A8A)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Branding
          const Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Smart Meter App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  '© 2025 Snapp Africa. All rights reserved.',
                  style: TextStyle(
                    color: Color(0xFF93C5FD),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Email capture
          Expanded(
            flex: 5,
            child: _submitted
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.check_circle_rounded,
                          color: Color(0xFF4ADE80), size: 16),
                      SizedBox(width: 6),
                      Text(
                        "Thanks! We'll be in touch.",
                        style: TextStyle(
                          color: Color(0xFF4ADE80),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 36,
                          child: TextField(
                            controller: _emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Enter your email...',
                              hintStyle: const TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 12,
                              ),
                              filled: true,
                              fillColor: const Color(0xFF1E293B),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        height: 36,
                        child: ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2563EB),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Subscribe',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
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
}