import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../config/image_config.dart';
import '../../../core/utils/url_helper.dart';
import '../../../core/widgets/arch_image.dart';
import '../../../core/widgets/page_banner.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/responsive_container.dart';
import '../../../core/widgets/section_heading.dart';
import '../../../core/widgets/site_page.dart';
import '../../home/widgets/home_sections.dart';

/// NOTE: copy is draft wording with no company facts. Please review and approve.
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Widget _block(String eyebrow, String title, String body, {bool light = false}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeading(eyebrow: eyebrow, title: title, light: light),
          const SizedBox(height: 20),
          Text(body, style: AppText.body(color: light ? const Color(0xFFC9CDC9) : AppColors.secondaryText, height: 1.9)),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return SitePage(
      path: '/about',
      body: Column(children: [
        const PageBanner(
          eyebrow: 'About us',
          title: 'KPGC Ventures Pvt. Ltd.',
          subtitle: 'Real estate development, residential construction and construction management in Ahilyanagar.',
          imageAsset: ImageConfig.royalWoodsNight,
        ),
        Section(
          child: SplitLayout(
            leftFlex: 6,
            rightFlex: 5,
            left: _block('Who we are', 'Building homes with care, clarity and intent.',
                'KPGC Ventures Pvt. Ltd. is a real estate builder and construction company based in Ahilyanagar, Maharashtra. Our work covers residential development, construction and project management, with Royal Woods as our featured project.'),
            right: const ArchImage(ImageConfig.royalWoodsDay, aspect: 1),
          ),
        ),
        Section(
          background: AppColors.white,
          child: SplitLayout(
            crossAxis: CrossAxisAlignment.start,
            left: _block('Vision', 'A trusted name in residential living.',
                'To be known for thoughtful design, dependable delivery and homes that stand the test of time.'),
            right: _block('Mission', 'Good design, sound construction, honest communication.',
                'To develop homes that balance considered design and quality construction with open, respectful dealings with every customer.'),
          ),
        ),
        Section(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SectionHeading(eyebrow: 'Core values', title: 'What guides our work.'),
            const SizedBox(height: 40),
            const ValuesSection(),
          ]),
        ),
        Section(
          background: AppColors.forest,
          child: SplitLayout(
            crossAxis: CrossAxisAlignment.start,
            left: _block('Construction philosophy', 'Quality is built, not added.',
                'We plan before we build, coordinate carefully on site and pay attention to details that shape daily living.',
                light: true),
            right: _block('Development approach', 'Planned around people.',
                'Every project begins with how residents will live in it: light, space, access and long-term maintainability.',
                light: true),
          ),
        ),
        Section(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _block('Commitment to customers', 'Clear answers, from first call to handover.',
                'We aim to give homebuyers clear information, timely responses and a single team to speak with throughout their journey.'),
            const SizedBox(height: 32),
            PrimaryButton(label: 'Contact Our Team', onDark: false, onPressed: () => UrlHelper.whatsapp(context)),
          ]),
        ),
      ]),
    );
  }
}
