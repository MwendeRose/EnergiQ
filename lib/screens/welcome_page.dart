// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/features_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _featuresKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Header(
              onAboutPressed: () => _scrollToSection(_aboutKey),
              onFeaturesPressed: () => _scrollToSection(_featuresKey),
              onContactPressed: () => _scrollToSection(_contactKey),
            ),
          ),
          const SliverToBoxAdapter(
            child: HeroSection(),
          ),
          SliverToBoxAdapter(
            child: AboutSection(key: _aboutKey),
          ),
          SliverToBoxAdapter(
            child: FeaturesSection(key: _featuresKey),
          ),
          SliverToBoxAdapter(
            child: ContactSection(key: _contactKey),
          ),
          const SliverToBoxAdapter(
            child: Footer(),
          ),
        ],
      ),
    );
  }
}