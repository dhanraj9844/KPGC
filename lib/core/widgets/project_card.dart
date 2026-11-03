import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../config/site_config.dart';
import '../../data/models/project_model.dart';
import '../utils/url_helper.dart';
import 'primary_button.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({super.key, required this.project});

  final ProjectModel project;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: AppColors.white,
        transform: Matrix4.translationValues(0, _hover ? -6 : 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 10,
              child: ClipRect(
                child: Stack(fit: StackFit.expand, children: [
                  AnimatedScale(
                    scale: _hover ? 1.04 : 1,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOut,
                    child: Image.asset(p.coverImage, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      color: AppColors.forest,
                      child: Text(p.statusLabel.toUpperCase(), style: AppText.eyebrow()),
                    ),
                  ),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.name, style: AppText.display(32, color: AppColors.forest)),
                  const SizedBox(height: 6),
                  Text(p.location, style: AppText.body(size: 13, color: AppColors.secondaryText)),
                  const SizedBox(height: 14),
                  Text(p.shortDescription, style: AppText.body(size: 14)),
                  const SizedBox(height: 24),
                  Wrap(spacing: 12, runSpacing: 12, children: [
                    PrimaryButton(label: 'View Project', onDark: false, onPressed: () => context.go('/projects/${p.slug}')),
                    PrimaryButton(
                      label: 'Enquire Now',
                      outlined: true,
                      onDark: false,
                      onPressed: () => UrlHelper.whatsapp(context, message: SiteConfig.whatsappMessage),
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
