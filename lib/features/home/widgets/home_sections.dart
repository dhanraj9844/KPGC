import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../config/image_config.dart';
import '../../../config/site_config.dart';
import '../../../core/utils/url_helper.dart';
import '../../../core/widgets/arch_image.dart';
import '../../../core/widgets/enquiry_form.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/reveal.dart';
import '../../../core/widgets/responsive_container.dart';
import '../../../core/widgets/section_heading.dart';
import '../../../data/mock/service_data.dart';
import '../../../data/repositories/project_repository.dart';

class CompanyIntroSection extends StatelessWidget {
  const CompanyIntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SplitLayout(
            leftFlex: 6,
            rightFlex: 5,
            left: Reveal(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeading(
                    eyebrow: 'Our approach',
                    title: 'More Than Structures. A Foundation for Better Living.',
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'KPGC Ventures Pvt. Ltd. approaches residential development with careful planning, quality-focused construction and open communication with every customer. We believe a home should be shaped around the way people live, and built to hold its value over time.',
                    style: AppText.body(color: AppColors.secondaryText, height: 1.9),
                  ),
                ],
              ),
            ),
            right: const ArchImage(ImageConfig.royalWoodsGate, aspect: 440 / 415),
          ),
          const SizedBox(height: 72),
          const ValuesSection(),
        ],
      ),
    );
  }
}

class ValuesSection extends StatelessWidget {
  const ValuesSection({super.key});

  static const _values = [
    ('01', 'Thoughtful Design', 'Homes planned around how people actually live.'),
    ('02', 'Quality-Focused Construction', 'Careful planning and workmanship at every stage.'),
    ('03', 'Customer-Centric Approach', 'Clear communication, from the first enquiry onward.'),
    ('04', 'Long-Term Value', 'Spaces built to remain relevant for years to come.'),
  ];

  @override
  Widget build(BuildContext context) {
    return ColumnsWrap(
      desktop: 4,
      tablet: 2,
      mobile: 1,
      children: [
        for (final v in _values)
          Container(
            padding: const EdgeInsets.only(top: 24),
            decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.lightGrey))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(v.$1, style: AppText.display(22, color: AppColors.gold)),
                const SizedBox(height: 10),
                Text(v.$2, style: AppText.display(21, color: AppColors.forest)),
                const SizedBox(height: 8),
                Text(v.$3, style: AppText.body(size: 13.5, color: AppColors.secondaryText)),
              ],
            ),
          ),
      ],
    );
  }
}

class FactList extends StatelessWidget {
  const FactList(this.facts, {super.key});

  final List<(String, String)> facts;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      for (final f in facts)
        Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.lightGrey))),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(width: 150, child: Text(f.$1.toUpperCase(), style: AppText.eyebrow(color: AppColors.secondaryText))),
            Expanded(child: Text(f.$2, style: AppText.body(size: 14))),
          ]),
        ),
    ]);
  }
}

class FeaturedProjectSection extends StatelessWidget {
  const FeaturedProjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    final p = ProjectRepository.featured;
    return Section(
      background: AppColors.white,
      child: SplitLayout(
        leftFlex: 5,
        rightFlex: 6,
        gap: 80,
        left: ArchImage(ImageConfig.royalWoodsNight, aspect: 383 / 441, label: '${p.name} architectural render'),
        right: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('FEATURED PROJECT', style: AppText.eyebrow()),
            const SizedBox(height: 14),
            Text(p.name, style: AppText.display(56, color: AppColors.forest)),
            const SizedBox(height: 8),
            Text(p.subtitle, style: AppText.body(color: AppColors.secondaryText)),
            const SizedBox(height: 28),
            FactList([
              ('Developer', p.developer),
              ('Location', p.address),
              ('Configurations', p.configurations ?? SiteConfig.pending),
              ('RERA & possession', SiteConfig.pending),
            ]),
            const SizedBox(height: 32),
            Wrap(spacing: 14, runSpacing: 14, children: [
              PrimaryButton(label: 'View Project', onDark: false, onPressed: () => context.go('/projects/${p.slug}')),
              PrimaryButton(
                label: 'Book a Site Visit',
                outlined: true,
                onDark: false,
                onPressed: () => UrlHelper.whatsapp(context, message: SiteConfig.messageFor('book a site visit')),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

class ServicesPreviewSection extends StatelessWidget {
  const ServicesPreviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(eyebrow: 'What we do', title: 'Development, construction and project management.'),
          const SizedBox(height: 40),
          for (final s in ServiceData.services)
            InkWell(
              onTap: () => context.go('/services'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 22),
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.lightGrey))),
                child: Row(children: [
                  Expanded(child: Text(s.title, style: AppText.display(24, color: AppColors.forest))),
                  const Icon(Icons.arrow_forward_rounded, color: AppColors.gold),
                ]),
              ),
            ),
          const SizedBox(height: 32),
          PrimaryButton(label: 'View All Services', onDark: false, onPressed: () => context.go('/services')),
        ],
      ),
    );
  }
}

class ContactCtaSection extends StatelessWidget {
  const ContactCtaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      background: AppColors.forest,
      child: SplitLayout(
        crossAxis: CrossAxisAlignment.start,
        left: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(
              light: true,
              eyebrow: 'Get in touch',
              title: 'Visit Royal Woods. Speak with our team.',
              subtitle: 'Share your details and we will get back to you with the latest project information.',
            ),
            const SizedBox(height: 28),
            Text('Anuron 7 Road, Behind DMart, Nandanvan Nagar,\nAhilyanagar, Maharashtra 414003',
                style: AppText.body(color: const Color(0xFFC9CDC9), height: 1.8)),
            const SizedBox(height: 18),
            PrimaryButton(label: SiteConfig.phoneDisplay, outlined: true, onPressed: () => UrlHelper.call(context)),
          ],
        ),
        right: const EnquiryForm(dark: true, initialType: 'Site Visit'),
      ),
    );
  }
}
