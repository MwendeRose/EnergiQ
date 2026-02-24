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

// ─── Design Tokens ─────────────────────────────────────────────
class AppColors {
  static const bg               = Color(0xFFEFF6FF);
  static const surface          = Color(0xFFFFFFFF);
  static const surfaceAlt       = Color(0xFFDBEAFE);
  static const border           = Color(0xFFBFD7F5);
  static const accent           = Color(0xFF2563EB);
  static const accentSoft       = Color(0x262563EB);
  static const textPrimary      = Color(0xFF0F172A);
  static const textSub          = Color(0xFF475569);
  static const textMuted        = Color(0xFF94A3B8);
  static const sidebarBg        = Color(0xFF1E40AF);
  static const sidebarSurface   = Color(0xFF1D3FAB);
  static const sidebarBorder    = Color(0xFF2D52C4);
  static const sidebarSelected  = Color(0xFF3B5FD4);
  static const sidebarText      = Color(0xFFEFF6FF);
  static const sidebarTextSub   = Color(0xFF93C5FD);
  static const sidebarIcon      = Color(0xFFBFD7F5);
  static const sidebarW         = 220.0;
  static const sidebarCollapsedW = 64.0;
}

// ─── Greeting helper ────────────────────────────────────────────
String _greeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) return 'Good Morning';
  if (hour < 17) return 'Good Afternoon';
  return 'Good Evening';
}

// ═══════════════════════════════════════════════════════════════
//  HomeScreen — thin shell, navigation handled by DashboardPage
// ═══════════════════════════════════════════════════════════════
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
    return HomeContentPage(
      pumpState: _pumpState,
      onGoToAlerts:    () => Navigator.of(context).maybePop(),
      onGoToAnalytics: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const AnalyticsPage()),
      ),
      onGoToSettings:  () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const SettingsPage()),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  HomeContentPage — reused by DashboardPage (index 1)
//
//  Navigation callbacks are passed in so DashboardPage can wire
//  them to its sidebar index instead of pushing new routes.
//
//  Layout:
//  ┌──────────────────────────────────────────┐
//  │  Greeting                  ● Live        │
//  ├──────────────────────────────────────────┤
//  │  AT A GLANCE          ────────────────── │
//  │  StatsRow                                │
//  ├──────────────────────────────────────────┤
//  │  ACTIVE ALERTS        ──── View All →   │
//  │  CriticalAlertCard                       │
//  ├──────────────────────────────────────────┤
//  │  BOREHOLE SYSTEM      ──── View Details →│
//  │  BoreholeSystemCard                      │
//  ├──────────────────────────────────────────┤
//  │  MAIN WATER METER     ──── View Details →│
//  │  WaterMeterCard                          │
//  ├──────────────────────────────────────────┤
//  │  UNIT SUB-METERS      ──── View Details →│
//  │  SubMetersGrid                           │
//  └──────────────────────────────────────────┘
// ═══════════════════════════════════════════════════════════════
class HomeContentPage extends StatelessWidget {
  final PumpStateNotifier pumpState;

  /// Navigate to the Alerts page
  final VoidCallback? onGoToAlerts;

  /// Navigate to the Analytics page (used by Meter / Sub-meter "View Details")
  final VoidCallback? onGoToAnalytics;

  /// Navigate to the Settings page
  final VoidCallback? onGoToSettings;

  const HomeContentPage({
    super.key,
    required this.pumpState,
    this.onGoToAlerts,
    this.onGoToAnalytics,
    this.onGoToSettings,
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

              // ── Greeting ──────────────────────────────────────
              _GreetingHeader(firstName: firstName),
              const SizedBox(height: 28),

              // ── Section 1: At a Glance ─────────────────────────
              const _SectionHeader(label: 'At a Glance'),
              const SizedBox(height: 10),
              const StatsRow(),
              const SizedBox(height: 28),

              // ── Section 2: Active Alerts ──────────────────────
              _SectionHeader(
                label: 'Active Alerts',
                actionLabel: 'View All',
                onAction: onGoToAlerts,
              ),
              const SizedBox(height: 10),
              CriticalAlertCard(onViewAlerts: onGoToAlerts ?? () {}),
              const SizedBox(height: 28),

              // ── Section 3: Borehole System ────────────────────
              _SectionHeader(
                label: 'Borehole System',
                actionLabel: 'View Details',
                onAction: onGoToAnalytics,
              ),
              const SizedBox(height: 10),
              BoreholeSystemCard(pumpState: pumpState),
              const SizedBox(height: 28),

              // ── Section 4: Main Water Meter ───────────────────
              _SectionHeader(
                label: 'Main Water Meter',
                actionLabel: 'View Details',
                onAction: onGoToAnalytics,
              ),
              const SizedBox(height: 10),
              WaterMeterCard(pumpState: pumpState),
              const SizedBox(height: 28),

              // ── Section 5: Unit Sub-Meters ────────────────────
              _SectionHeader(
                label: 'Unit Sub-Meters',
                actionLabel: 'View Details',
                onAction: onGoToAnalytics,
              ),
              const SizedBox(height: 10),
              const SubMetersGrid(),

            ],
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  GREETING HEADER
// ═══════════════════════════════════════════════════════════════
class _GreetingHeader extends StatelessWidget {
  final String firstName;
  const _GreetingHeader({required this.firstName});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                'Live overview of your borehole system.',
                style: TextStyle(
                  color: AppColors.textSub,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        // Live status pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFDCFCE7),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF86EFAC)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: Color(0xFF16A34A),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                'Live',
                style: TextStyle(
                  color: Color(0xFF15803D),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  SECTION HEADER — label + horizontal rule + optional nav link
//  No icons anywhere.
// ═══════════════════════════════════════════════════════════════
class _SectionHeader extends StatelessWidget {
  final String label;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _SectionHeader({
    required this.label,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Bold section label
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: AppColors.textMuted,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(width: 10),
        // Expanding divider
        const Expanded(
          child: Divider(
            color: AppColors.border,
            thickness: 1,
            height: 1,
          ),
        ),
        // Navigatable "View All" / "View Details" link
        if (actionLabel != null && onAction != null) ...[
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onAction,
            child: Text(
              actionLabel!,
              style: const TextStyle(
                color: AppColors.accent,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.accent,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// ─── Top Bar (kept for standalone / narrow use) ─────────────────
class _TopBar extends StatelessWidget {
  final String title, location;
  final VoidCallback onAlerts;
  const _TopBar({
    required this.title,
    required this.onAlerts,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final locationLabel = location.isNotEmpty ? '$location • Live' : 'Live';
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: const Border(
            bottom: BorderSide(color: AppColors.border, width: 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFBFD7F5)),
            ),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFF22C55E),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  locationLabel,
                  style: const TextStyle(
                    color: Color(0xFF1D4ED8),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.textSub,
                  size: 20,
                ),
                onPressed: onAlerts,
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}