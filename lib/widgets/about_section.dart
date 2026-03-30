// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF9FAFB),
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
                  'About Smart-meters app',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF7C2D12),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Empowering smarter energy decisions',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const Text(
                'Smart-meters app is a cutting-edge energy management platform designed to help households and businesses monitor, analyze, and optimize their energy consumption in real-time.',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF4B5563),
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Founded in 2024, our mission is to make energy management accessible to everyone. We believe that by providing clear insights and actionable recommendations, we can help reduce energy waste, lower costs, and contribute to a more sustainable future.',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF4B5563),
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildStatCard('150+', 'Countries Worldwide'),
                  const SizedBox(width: 24),
                  _buildStatCard('99.9%', 'Uptime Guarantee'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(0xFFF97316),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF4B5563),
            ),
          ),
        ],
      ),
    );
  }
}