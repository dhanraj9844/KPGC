import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../config/site_config.dart';
import '../../../core/utils/url_helper.dart';
import '../../../core/widgets/enquiry_form.dart';
import '../../../core/widgets/page_banner.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/responsive_container.dart';
import '../../../core/widgets/site_page.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget label(String t) => Padding(
          padding: const EdgeInsets.only(top: 28, bottom: 8),
          child: Text(t.toUpperCase(), style: AppText.eyebrow()),
        );
    return SitePage(
      path: '/contact',
      body: Column(children: [
        const PageBanner(eyebrow: 'Contact', title: 'Contact Our Team', subtitle: 'Enquiries, site visits and project details.'),
        Section(
          child: SplitLayout(
            crossAxis: CrossAxisAlignment.start,
            leftFlex: 4,
            rightFlex: 6,
            left: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(SiteConfig.companyName, style: AppText.display(30, color: AppColors.forest)),
              label('Address'),
              Text(SiteConfig.fullAddress, style: AppText.body(height: 1.8)),
              label('Phone'),
              Text(SiteConfig.phoneDisplay, style: AppText.body()),
              if (SiteConfig.email != null) ...[label('Email'), Text(SiteConfig.email!, style: AppText.body())],
              const SizedBox(height: 28),
              Wrap(spacing: 12, runSpacing: 12, children: [
                PrimaryButton(label: 'Call Now', onDark: false, onPressed: () => UrlHelper.call(context)),
                PrimaryButton(label: 'WhatsApp', outlined: true, onDark: false, onPressed: () => UrlHelper.whatsapp(context)),
                PrimaryButton(label: 'Open in Google Maps', outlined: true, onDark: false, onPressed: () => UrlHelper.maps(context)),
              ]),
            ]),
            right: Container(
              padding: const EdgeInsets.all(32),
              color: AppColors.white,
              child: const EnquiryForm(),
            ),
          ),
        ),
      ]),
    );
  }
}
