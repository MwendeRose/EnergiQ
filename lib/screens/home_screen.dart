// lib/screens/home_screen.dart
// ignore_for_file: unnecessary_underscores, deprecated_member_use, unused_import, unused_element

import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/borehole_system_card.dart';
import '../widgets/water_meter_card.dart';
import '../widgets/sub_meters_grid.dart';
import '../widgets/stats_row.dart';
import '../widgets/critical_alert_card.dart';
import 'analytics.dart';
import 'settings.dart';
import 'alerts_page.dart';
import 'dashboard_page.dart';

// ─── Design Tokens ────────────────────────────────────────────
class AppColors {
  static const bg            = Color(0xFFEFF6FF);
  static const surface       = Color(0xFFFFFFFF);
  static const surfaceAlt    = Color(0xFFDBEAFE);
  static const border        = Color(0xFFBFD7F5);
  static const accent        = Color(0xFF2563EB);
  static const accentSoft    = Color(0x262563EB);
  static const textPrimary   = Color(0xFF0F172A);
  static const textSub       = Color(0xFF475569);
  static const textMuted     = Color(0xFF94A3B8);
  static const sidebarBg     = Color(0xFF1E40AF);
  static const sidebarSurface   = Color(0xFF1D3FAB);
  static const sidebarBorder    = Color(0xFF2D52C4);
  static const sidebarSelected  = Color(0xFF3B5FD4);
  static const sidebarText      = Color(0xFFEFF6FF);
  static const sidebarTextSub   = Color(0xFF93C5FD);
  static const sidebarIcon      = Color(0xFFBFD7F5);
  static const sidebarW         = 220.0;
  static const sidebarCollapsedW = 64.0;
}

// ─── Greeting helper ───────────────────────────────────────────
String _greeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) return 'Good Morning';
  if (hour < 17) return 'Good Afternoon';
  return 'Good Evening';
}

// ══════════════════════════════════════════════════════════════
//  HomeScreen — NO sidebar. Navigation is handled by DashboardPage.
//  This widget now just renders the home content directly.
// ══════════════════════════════════════════════════════════════
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pumpState = PumpStateNotifier(initiallyRunning: true);

  @override
  void dispose() {
    _pumpState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // HomeScreen no longer manages a sidebar or bottom nav —
    // that is the responsibility of DashboardPage.
    return HomeContentPage(
      pumpState: _pumpState,
      onGoToAlerts: () {
        // If opened standalone (e.g. during onboarding) just pop
        Navigator.of(context).maybePop();
      },
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  HomeContentPage — the actual content; reused by DashboardPage
// ══════════════════════════════════════════════════════════════
class HomeContentPage extends StatelessWidget {
  final PumpStateNotifier pumpState;
  final VoidCallback? onGoToAlerts;

  const HomeContentPage({
    super.key,
    required this.pumpState,
    this.onGoToAlerts,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AuthService.instance,
      builder: (context, _) {
        final firstName = AuthService.instance.user?.firstName ?? 'there';
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              Text(
                '${_greeting()}, $firstName 👋',
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Here\'s a live overview of your borehole system.',
                style: TextStyle(color: AppColors.textSub, fontSize: 13),
              ),
              const SizedBox(height: 24),

              // Stats row
              const StatsRow(),
              const SizedBox(height: 20),

              // Critical alert card (taps navigate to Alerts)
              CriticalAlertCard(onViewAlerts: onGoToAlerts ?? () {}),
              const SizedBox(height: 20),

              // Borehole system card
              BoreholeSystemCard(pumpState: pumpState),
              const SizedBox(height: 20),

              // Main water meter
              WaterMeterCard(pumpState: pumpState),
              const SizedBox(height: 20),

              // Sub-meters grid
              const SubMetersGrid(),
            ],
          ),
        );
      },
    );
  }
}

// ─── Top Bar (kept for standalone / narrow use if ever needed) ─
class _TopBar extends StatelessWidget {
  final String title, location;
  final VoidCallback onAlerts;
  const _TopBar({required this.title, required this.onAlerts, required this.location});

  @override
  Widget build(BuildContext context) {
    final locationLabel = location.isNotEmpty ? '$location • Live' : 'Live';
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: const Border(bottom: BorderSide(color: AppColors.border, width: 1)),
        boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(children: [
        Text(title,
            style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600)),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFBFD7F5)),
          ),
          child: Row(children: [
            Container(width: 6, height: 6,
                decoration: const BoxDecoration(color: Color(0xFF22C55E), shape: BoxShape.circle)),
            const SizedBox(width: 6),
            Text(locationLabel,
                style: const TextStyle(
                    color: Color(0xFF1D4ED8), fontSize: 12, fontWeight: FontWeight.w500)),
          ]),
        ),
        const SizedBox(width: 12),
        Stack(clipBehavior: Clip.none, children: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined,
                color: AppColors.textSub, size: 20),
            onPressed: onAlerts,
          ),
          Positioned(
            top: 8, right: 8,
            child: Container(
                width: 8, height: 8,
                decoration: const BoxDecoration(
                    color: Color(0xFFEF4444), shape: BoxShape.circle)),
          ),
        ]),
      ]),
    );
  }
}