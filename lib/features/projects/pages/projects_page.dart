import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/widgets/page_banner.dart';
import '../../../core/widgets/project_card.dart';
import '../../../core/widgets/responsive_container.dart';
import '../../../core/widgets/site_page.dart';
import '../../../data/models/project_model.dart';
import '../../../data/repositories/project_repository.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  ProjectStatus _status = ProjectStatus.ongoing;

  static const _labels = {
    ProjectStatus.ongoing: 'Ongoing Projects',
    ProjectStatus.completed: 'Completed Projects',
    ProjectStatus.upcoming: 'Upcoming Projects',
  };

  @override
  Widget build(BuildContext context) {
    final items = ProjectRepository.byStatus(_status);
    return SitePage(
      path: '/projects',
      body: Column(children: [
        const PageBanner(eyebrow: 'Portfolio', title: 'Our Projects', subtitle: 'Residential developments by KPGC Ventures Pvt. Ltd.'),
        Section(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Wrap(spacing: 8, runSpacing: 8, children: [
              for (final e in _labels.entries)
                ChoiceChip(
                  label: Text(e.value, style: AppText.body(size: 13, color: _status == e.key ? AppColors.white : AppColors.forest, weight: FontWeight.w600)),
                  selected: _status == e.key,
                  showCheckmark: false,
                  selectedColor: AppColors.forest,
                  backgroundColor: AppColors.white,
                  shape: const RoundedRectangleBorder(side: BorderSide(color: AppColors.forest)),
                  onSelected: (_) => setState(() => _status = e.key),
                ),
            ]),
            const SizedBox(height: 40),
            if (items.isEmpty)
              Text('No verified projects in this category yet.', style: AppText.body(color: AppColors.secondaryText))
            else
              ColumnsWrap(desktop: 2, tablet: 1, mobile: 1, gap: 40, children: [for (final p in items) ProjectCard(project: p)]),
          ]),
        ),
      ]),
    );
  }
}
