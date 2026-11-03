import 'package:flutter/material.dart';

import '../../../core/widgets/site_page.dart';
import '../widgets/construction_video_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/home_sections.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SitePage(
      path: '/',
      body: Column(children: [
        HeroSection(),
        CompanyIntroSection(),
        FeaturedProjectSection(),
        ConstructionVideoSection(),
        ServicesPreviewSection(),
        ContactCtaSection(),
      ]),
    );
  }
}
