import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../config/image_config.dart';
import '../../../config/site_config.dart';
import '../../../core/utils/url_helper.dart';
import '../../../core/widgets/arch_image.dart';
import '../../../core/widgets/enquiry_form.dart';
import '../../../core/widgets/image_gallery.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/responsive_container.dart';
import '../../../core/widgets/section_heading.dart';
import '../../../data/models/project_model.dart';
import '../../home/widgets/home_sections.dart';

class ProjectOverview extends StatelessWidget {
  const ProjectOverview({super.key, required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return Section(
      background: AppColors.white,
      child: SplitLayout(
        leftFlex: 5,
        rightFlex: 6,
        left: const ArchImage(ImageConfig.royalWoodsNight, aspect: 383 / 441),
        right: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SectionHeading(eyebrow: 'Project overview', title: project.subtitle),
          const SizedBox(height: 20),
          Text(
            '${project.name} is a residential development by ${project.developer}, located on Anuron 7 Road, behind DMart, Nandanvan Nagar, Ahilyanagar.',
            style: AppText.body(color: AppColors.secondaryText, height: 1.9),
          ),
          const SizedBox(height: 28),
          FactList([
            ('Developer', project.developer),
            ('Location', project.address),
            ('Status', project.statusLabel),
            ('Configurations', project.configurations ?? SiteConfig.pending),
            ('MahaRERA no.', project.reraNumber ?? SiteConfig.pending),
            ('Possession', project.possession ?? SiteConfig.pending),
            ('Pricing', SiteConfig.pending),
          ]),
          const SizedBox(height: 28),
          Wrap(spacing: 14, runSpacing: 14, children: [
            PrimaryButton(label: 'Book a Site Visit', onDark: false, onPressed: () => UrlHelper.whatsapp(context, message: SiteConfig.messageFor('book a site visit'))),
            PrimaryButton(label: 'Get Project Details', outlined: true, onDark: false, onPressed: () => UrlHelper.whatsapp(context)),
          ]),
        ]),
      ),
    );
  }
}

/// Amenities, configurations and specifications: only verified data is shown.
class ProjectDetailsSection extends StatelessWidget {
  const ProjectDetailsSection({super.key, required this.project});

  final ProjectModel project;

  Widget _block(String title, List<String> items) => Container(
        padding: const EdgeInsets.all(28),
        color: AppColors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: AppText.display(24, color: AppColors.forest)),
          const SizedBox(height: 16),
          if (items.isEmpty)
            Text(SiteConfig.pending, style: AppText.body(size: 14, color: AppColors.secondaryText))
          else
            for (final i in items)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text('—  $i', style: AppText.body(size: 14)),
              ),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    return Section(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SectionHeading(eyebrow: 'Project details', title: 'Amenities, configurations & specifications'),
        const SizedBox(height: 40),
        ColumnsWrap(desktop: 3, tablet: 1, mobile: 1, gap: 24, children: [
          _block('Amenities', project.amenities),
          _block('Apartment Configurations', project.configurations == null ? const [] : [project.configurations!]),
          _block('Specifications', project.specifications),
        ]),
      ]),
    );
  }
}

class FloorPlanSection extends StatelessWidget {
  const FloorPlanSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      background: AppColors.forest,
      child: Column(children: [
        const SectionHeading(eyebrow: 'Floor plans', title: 'Floor Plans & Brochure', light: true, center: true),
        const SizedBox(height: 20),
        Text(
          'Interested in floor plans? Contact our team to request the latest project details.',
          textAlign: TextAlign.center,
          style: AppText.body(color: const Color(0xFFC9CDC9), height: 1.8),
        ),
        const SizedBox(height: 32),
        Wrap(alignment: WrapAlignment.center, spacing: 14, runSpacing: 14, children: [
          PrimaryButton(label: 'Request Floor Plans', onPressed: () => UrlHelper.whatsapp(context, message: SiteConfig.messageFor('request the floor plans'))),
          PrimaryButton(label: 'Request a Brochure', outlined: true, onPressed: () => UrlHelper.whatsapp(context, message: SiteConfig.messageFor('request the brochure'))),
        ]),
      ]),
    );
  }
}

class ProjectGallerySection extends StatelessWidget {
  const ProjectGallerySection({super.key, required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final items = [for (final a in project.gallery) GalleryItem(a, 'Architectural render', 'Architecture')];
    return Section(
      background: AppColors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SectionHeading(eyebrow: 'Gallery', title: 'Project gallery'),
        const SizedBox(height: 40),
        ColumnsWrap(desktop: 3, tablet: 2, mobile: 1, gap: 20, children: [
          for (var i = 0; i < items.length; i++) GalleryTile(items: items, index: i),
        ]),
      ]),
    );
  }
}

class ProjectEnquirySection extends StatelessWidget {
  const ProjectEnquirySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      background: AppColors.forest,
      child: SplitLayout(
        crossAxis: CrossAxisAlignment.start,
        left: const SectionHeading(
          light: true,
          eyebrow: 'Enquire',
          title: 'Interested in Royal Woods?',
          subtitle: 'Tell us how to reach you and our team will share the latest project details.',
        ),
        right: const EnquiryForm(dark: true, initialType: 'Project Details'),
      ),
    );
  }
}
