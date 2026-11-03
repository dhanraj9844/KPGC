import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../config/site_config.dart';
import '../../data/mock/service_data.dart';
import '../utils/url_helper.dart';
import 'kpgc_logo.dart';
import 'responsive_container.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final brand = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const KpgcLogo(),
        const SizedBox(height: 20),
        Text(SiteConfig.tagline, style: AppText.display(20, color: AppColors.gold)),
        const SizedBox(height: 14),
        Text(
          'Real estate development, residential construction and construction management in Ahilyanagar, Maharashtra.',
          style: AppText.body(size: 13, color: const Color(0xFF9AA39D)),
        ),
      ],
    );
    final navigate = _Column('Navigate', [
      _Link('Home', () => context.go('/')),
      _Link('About Us', () => context.go('/about')),
      _Link('Projects', () => context.go('/projects')),
      _Link('Services', () => context.go('/services')),
      _Link('Gallery', () => context.go('/gallery')),
      _Link('Contact', () => context.go('/contact')),
    ]);
    final work = _Column('Projects & Services', [
      _Link('Royal Woods', () => context.go('/projects/royal-woods')),
      for (final s in ServiceData.services) _Link(s.title, () => context.go('/services')),
    ]);
    final contact = _Column('Contact', [
      _Link(SiteConfig.phoneDisplay, () => UrlHelper.call(context)),
      _Link('WhatsApp', () => UrlHelper.whatsapp(context)),
      _Link('View on Google Maps', () => UrlHelper.maps(context)),
      Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Text('Anuron 7 Road, Behind DMart,\nNandanvan Nagar, Ahilyanagar,\nMaharashtra 414003',
            style: AppText.body(size: 13, color: const Color(0xFF9AA39D))),
      ),
    ]);

    final wide = MediaQuery.sizeOf(context).width >= 1024;
    return Container(
      width: double.infinity,
      color: AppColors.deepForest,
      child: ResponsiveContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 72),
            if (wide)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: brand),
                  const SizedBox(width: 48),
                  Expanded(flex: 2, child: navigate),
                  Expanded(flex: 3, child: work),
                  Expanded(flex: 3, child: contact),
                ],
              )
            else
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                brand,
                const SizedBox(height: 40),
                navigate,
                const SizedBox(height: 40),
                work,
                const SizedBox(height: 40),
                contact,
              ]),
            const SizedBox(height: 48),
            const Divider(color: Color(0xFF2E3A33), height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 8,
                children: [
                  Text('© ${DateTime.now().year} ${SiteConfig.companyName} All rights reserved.',
                      style: AppText.body(size: 12, color: const Color(0xFF8A938D))),
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    _Link('Privacy Policy', () => context.go('/privacy')),
                    const SizedBox(width: 20),
                    _Link('Terms & Conditions', () => context.go('/terms')),
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

class _Column extends StatelessWidget {
  const _Column(this.title, this.children);

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(), style: AppText.eyebrow()),
          const SizedBox(height: 16),
          ...children,
        ],
      );
}

class _Link extends StatelessWidget {
  const _Link(this.label, this.onTap);

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(label, style: AppText.body(size: 13, color: const Color(0xFFC9CDC9))),
          ),
        ),
      );
}
