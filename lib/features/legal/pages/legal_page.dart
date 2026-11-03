import 'package:flutter/material.dart';

import '../../../app/theme/app_text_styles.dart';
import '../../../config/site_config.dart';
import '../../../core/widgets/page_banner.dart';
import '../../../core/widgets/responsive_container.dart';
import '../../../core/widgets/site_page.dart';

enum LegalKind { privacy, terms }

/// DRAFT placeholder text. Have a legal professional review before launch.
class LegalPage extends StatelessWidget {
  const LegalPage({super.key, required this.kind});

  final LegalKind kind;

  @override
  Widget build(BuildContext context) {
    final privacy = kind == LegalKind.privacy;
    final title = privacy ? 'Privacy Policy' : 'Terms & Conditions';
    final paragraphs = privacy
        ? [
            'This website does not store enquiries. When you submit the enquiry form, your details are placed in a WhatsApp message that you choose to send to ${SiteConfig.companyName}.',
            'We use the details you share only to respond to your enquiry. For questions about your information, contact us on ${SiteConfig.phoneDisplay}.',
          ]
        : [
            'The information on this website is for general guidance and may change. Images are architectural renders and are indicative only.',
            'Project details such as configurations, pricing, availability and possession must be confirmed with ${SiteConfig.companyName} before any decision is made.',
          ];
    return SitePage(
      path: kind == LegalKind.privacy ? '/privacy' : '/terms',
      body: Column(children: [
        PageBanner(eyebrow: 'Legal', title: title),
        Section(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            for (final p in paragraphs)
              Padding(padding: const EdgeInsets.only(bottom: 20), child: Text(p, style: AppText.body(height: 1.9))),
            Text('Draft text. To be reviewed and approved by ${SiteConfig.companyName}.', style: AppText.body(size: 12)),
          ]),
        ),
      ]),
    );
  }
}
