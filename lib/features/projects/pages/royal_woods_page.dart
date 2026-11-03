import 'package:flutter/material.dart';

import '../../../config/image_config.dart';
import '../../../core/widgets/page_banner.dart';
import '../../../core/widgets/site_page.dart';
import '../../../data/repositories/project_repository.dart';
import '../widgets/project_sections.dart';

class RoyalWoodsPage extends StatelessWidget {
  const RoyalWoodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final p = ProjectRepository.bySlug('royal-woods') ?? ProjectRepository.featured;
    return SitePage(
      path: '/projects/royal-woods',
      body: Column(children: [
        PageBanner(eyebrow: 'Featured project', title: p.name, subtitle: p.subtitle, imageAsset: ImageConfig.royalWoodsGate),
        ProjectOverview(project: p),
        ProjectDetailsSection(project: p),
        const FloorPlanSection(),
        ProjectGallerySection(project: p),
        const ProjectEnquirySection(),
      ]),
    );
  }
}
