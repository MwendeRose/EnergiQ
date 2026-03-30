// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 96),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFEFF6FF), // bright sky blue
            Color(0xFFF0F9FF), // ice blue
            Color(0xFFEEF2FF), // soft indigo-white
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            children: [
              // ── Badge ──────────────────────────────────────
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFDBEAFE),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: const Color(0xFF93C5FD), width: 1),
                ),
                child: const Text(
                  'Features',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1D4ED8),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ── Heading ────────────────────────────────────
              const Text(
                'Everything you need to manage energy',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // ── Subtitle ───────────────────────────────────
              const Text(
                'Comprehensive tools and insights to help you understand and optimize your energy consumption',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF4B5563),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 64),

              // ── Cards ──────────────────────────────────────
              Wrap(
                spacing: 32,
                runSpacing: 32,
                children: [
                  _buildFeatureCard(
                    Icons.flash_on,
                    'Real-Time Monitoring',
                    'Track your energy consumption in real-time with live updates every second. See exactly what\'s using power right now.',
                    const Color(0xFFDCFCE7), // green tint
                    const Color(0xFF16A34A),
                    const Color(0xFFBBF7D0),
                  ),
                  _buildFeatureCard(
                    Icons.bar_chart,
                    'Smart Analytics',
                    'Get detailed insights with AI-powered analytics that identify patterns and suggest optimization opportunities.',
                    const Color(0xFFDBEAFE), // blue tint
                    const Color(0xFF2563EB),
                    const Color(0xFFBFDBFE),
                  ),
                  _buildFeatureCard(
                    Icons.notifications,
                    'Smart Alerts',
                    'Receive instant notifications when unusual energy consumption is detected or when devices are left on.',
                    const Color(0xFFFEF9C3), // yellow tint
                    const Color(0xFFCA8A04),
                    const Color(0xFFFDE68A),
                  ),
                  _buildFeatureCard(
                    Icons.attach_money,
                    'Cost Tracking',
                    'Monitor your energy costs in real-time and get accurate predictions for your monthly bills.',
                    const Color(0xFFD1FAE5), // emerald tint
                    const Color(0xFF059669),
                    const Color(0xFFA7F3D0),
                  ),
                  _buildFeatureCard(
                    Icons.home,
                    'Device Control',
                    'Control smart devices directly from the app. Turn off appliances remotely and create automated schedules.',
                    const Color(0xFFEDE9FE), // violet tint
                    const Color(0xFF7C3AED),
                    const Color(0xFFDDD6FE),
                  ),
                  _buildFeatureCard(
                    Icons.security,
                    'Secure & Private',
                    'Your data is encrypted end-to-end. We never share your information with third parties.',
                    const Color(0xFFFFE4E6), // rose tint
                    const Color(0xFFE11D48),
                    const Color(0xFFFECDD3),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    IconData icon,
    String title,
    String description,
    Color bgTint,
    Color iconColor,
    Color iconBg,
  ) {
    return Container(
      width: 380,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE0EAFF), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2563EB).withOpacity(0.07),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF4B5563),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}