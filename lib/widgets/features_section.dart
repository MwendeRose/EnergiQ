// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 96),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFED7AA),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Text(
                  'Features',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF7C2D12),
                  ),
                ),
              ),
              const SizedBox(height: 24),
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
              const Text(
                'Comprehensive tools and insights to help you understand and optimize your energy consumption',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF4B5563),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 64),
              Wrap(
                spacing: 32,
                runSpacing: 32,
                children: [
                  _buildFeatureCard(
                    Icons.flash_on,
                    'Real-Time Monitoring',
                    'Track your energy consumption in real-time with live updates every second. See exactly what\'s using power right now.',
                  ),
                  _buildFeatureCard(
                    Icons.bar_chart,
                    'Smart Analytics',
                    'Get detailed insights with AI-powered analytics that identify patterns and suggest optimization opportunities.',
                  ),
                  _buildFeatureCard(
                    Icons.notifications,
                    'Smart Alerts',
                    'Receive instant notifications when unusual energy consumption is detected or when devices are left on.',
                  ),
                  _buildFeatureCard(
                    Icons.attach_money,
                    'Cost Tracking',
                    'Monitor your energy costs in real-time and get accurate predictions for your monthly bills.',
                  ),
                  _buildFeatureCard(
                    Icons.home,
                    'Device Control',
                    'Control smart devices directly from the app. Turn off appliances remotely and create automated schedules.',
                  ),
                  _buildFeatureCard(
                    Icons.security,
                    'Secure & Private',
                    'Your data is encrypted end-to-end. We never share your information with third parties.',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, String description) {
    return Container(
      width: 380,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFFED7AA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFF97316),
              size: 28,
            ),
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