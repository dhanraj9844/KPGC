import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../config/image_config.dart';
import '../../../config/site_config.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../core/utils/url_helper.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/reveal.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final desktop = Responsive.isDesktop(context);
    final pad = Responsive.hPad(context);
    final headline = Responsive.pick<double>(context, mobile: 38, tablet: 54, desktop: 72);

    final text = Padding(
      padding: EdgeInsets.fromLTRB(pad, desktop ? 140 : 40, pad, desktop ? 80 : 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Reveal(child: Text('REAL ESTATE • DEVELOPMENT • CONSTRUCTION', style: AppText.eyebrow())),
          const SizedBox(height: 24),
          Reveal(
            delay: 150.ms,
            child: Text('Building Spaces.\nCreating Legacies.', style: AppText.display(headline, height: 1.06)),
          ),
          const SizedBox(height: 24),
          Reveal(
            delay: 300.ms,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Text(
                'Thoughtfully developed spaces designed around modern living, enduring quality, and the aspirations of every homeowner.',
                style: AppText.body(color: const Color(0xFFC9CDC9), height: 1.8),
              ),
            ),
          ),
          const SizedBox(height: 36),
          Reveal(
            delay: 450.ms,
            child: Wrap(spacing: 14, runSpacing: 14, children: [
              PrimaryButton(label: 'Explore Our Projects', onPressed: () => context.go('/projects')),
              PrimaryButton(
                label: 'Book a Site Visit',
                outlined: true,
                onPressed: () => UrlHelper.whatsapp(context, message: SiteConfig.messageFor('book a site visit')),
              ),
            ]),
          ),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.only(top: 14),
            decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.gold))),
            child: Text('AHILYANAGAR, MAHARASHTRA', style: AppText.eyebrow()),
          ),
        ],
      ),
    );

    final image = Stack(fit: StackFit.expand, children: [
      Semantics(
        image: true,
        label: 'Royal Woods architectural render',
        child: Image.asset(ImageConfig.heroImage, fit: BoxFit.cover, alignment: Alignment.topCenter),
      ),
      const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [Color(0x99000000), Color(0x00000000)],
          ),
        ),
      ),
    ]);

    if (!desktop) {
      return Container(
        color: AppColors.forest,
        child: Column(children: [
          SizedBox(height: Responsive.isMobile(context) ? 440 : 560, width: double.infinity, child: image),
          text,
        ]),
      );
    }
    return Container(
      color: AppColors.forest,
      height: 780,
      child: Row(children: [
        Expanded(flex: 11, child: text),
        Expanded(flex: 9, child: image),
      ]),
    );
  }
}
