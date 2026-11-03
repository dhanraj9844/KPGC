import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../config/site_config.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../core/utils/url_helper.dart';
import '../../../core/widgets/arch_image.dart';
import '../../../core/widgets/page_banner.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/responsive_container.dart';
import '../../../core/widgets/section_heading.dart';
import '../../../core/widgets/site_page.dart';
import '../../../data/mock/service_data.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SitePage(
      path: '/services',
      body: Column(children: [
        const PageBanner(eyebrow: 'Services', title: 'What We Do', subtitle: 'From development to construction management, delivered with care.'),
        for (var i = 0; i < ServiceData.services.length; i++) _row(context, i),
      ]),
    );
  }

  Widget _row(BuildContext context, int i) {
    final s = ServiceData.services[i];
    final image = ArchImage(s.image, aspect: 4 / 3, label: s.title);
    final text = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SectionHeading(eyebrow: '0${i + 1}', title: s.title),
      const SizedBox(height: 18),
      Text(s.description, style: AppText.body(color: AppColors.secondaryText, height: 1.9)),
      const SizedBox(height: 18),
      for (final b in s.benefits)
        Padding(padding: const EdgeInsets.only(bottom: 6), child: Text('—  $b', style: AppText.body(size: 14))),
      const SizedBox(height: 22),
      PrimaryButton(
        label: 'Enquire Now',
        onDark: false,
        onPressed: () => UrlHelper.whatsapp(context, message: 'Hello KPGC Ventures, I would like to enquire about ${s.title}.'),
      ),
    ]);
    final imageFirst = i.isEven || !Responsive.isDesktop(context);
    return Section(
      background: i.isEven ? AppColors.ivory : AppColors.white,
      child: SplitLayout(left: imageFirst ? image : text, right: imageFirst ? text : image),
    );
  }
}
