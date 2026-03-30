// ignore_for_file: use_super_parameters, unnecessary_underscores

import 'package:flutter/material.dart';
import 'package:smart_app/screens/login_page.dart'; // adjust import path as needed

class Header extends StatelessWidget {
  final VoidCallback onAboutPressed;
  final VoidCallback onFeaturesPressed;
  final VoidCallback onContactPressed;

  const Header({
    Key? key,
    required this.onAboutPressed,
    required this.onFeaturesPressed,
    required this.onContactPressed,
  }) : super(key: key);

  void _goToLogin(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) => const LoginPage(),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          bottom: BorderSide(color: Color(0xFFE8EEFF), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B4FD8).withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        
          Row(
            children: [
              // Larger container: 88×88, no padding, full bleed image
              SizedBox(
                width: 88,
                height: 88,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    'assets/logosnapp.jpeg',
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    errorBuilder: (_, __, ___) => const _FallbackLogo(),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF111827),
                    letterSpacing: -0.3,
                  ),
                  children: [
                    TextSpan(text: 'Smart-Meters'),
                    TextSpan(
                      text: 'App',
                      style: TextStyle(color: Color(0xFF2563EB)),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // ── Nav links (wide screens only) ────────────────
          if (MediaQuery.of(context).size.width > 768)
            Row(
              children: [
                _NavLink(label: 'About', onPressed: onAboutPressed),
                const SizedBox(width: 28),
                _NavLink(label: 'Features', onPressed: onFeaturesPressed),
                const SizedBox(width: 28),
                _NavLink(label: 'Contact', onPressed: onContactPressed),
                const SizedBox(width: 28),

                // Sign In button → navigates to LoginPage
                ElevatedButton(
                  onPressed: () => _goToLogin(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B4FD8),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 11,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    elevation: 0,
                    shadowColor: const Color(0xFF1B4FD8).withOpacity(0.3),
                  ).copyWith(
                    elevation: WidgetStateProperty.resolveWith((states) =>
                        states.contains(WidgetState.hovered) ? 4 : 0),
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),

          // ── Mobile: sign-in icon ──────────────────────────
          if (MediaQuery.of(context).size.width <= 768)
            IconButton(
              onPressed: () => _goToLogin(context),
              icon: const Icon(Icons.person_outline_rounded,
                  color: Color(0xFF1B4FD8), size: 26),
              tooltip: 'Sign In',
            ),
        ],
      ),
    );
  }
}

// ── Nav link helper ───────────────────────────────────────────
class _NavLink extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _NavLink({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF374151),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        overlayColor: const Color(0xFF1B4FD8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF374151),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ── Logo fallback (Snapp Africa style) ───────────────────────
class _FallbackLogo extends StatelessWidget {
  const _FallbackLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D0D0D),
      alignment: Alignment.center,
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '>',
            style: TextStyle(
              color: Color(0xFFFFAA00),
              fontSize: 20,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              height: 1,
            ),
          ),
          SizedBox(width: 3),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SNAPP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                  height: 1,
                ),
              ),
              Text(
                'AFRICA',
                style: TextStyle(
                  color: Color(0xFFFFAA00),
                  fontSize: 5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}