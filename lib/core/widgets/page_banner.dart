import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../utils/responsive_helper.dart';
import 'reveal.dart';
import 'responsive_container.dart';

class PageBanner extends StatelessWidget {
  const PageBanner({super.key, required this.eyebrow, required this.title, this.subtitle, this.imageAsset});

  final String eyebrow;
  final String title;
  final String? subtitle;
  final String? imageAsset;

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    return Container(
      width: double.infinity,
      color: AppColors.forest,
      child: Stack(
        children: [
          if (imageAsset != null)
            Positioned.fill(
              child: Opacity(
                opacity: 0.28,
                child: Image.asset(imageAsset!, fit: BoxFit.cover, alignment: Alignment.center),
              ),
            ),
          Padding(
            padding: EdgeInsets.only(top: mobile ? 130 : 180, bottom: mobile ? 56 : 90),
            child: ResponsiveContainer(
              child: Reveal(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(eyebrow.toUpperCase(), style: AppText.eyebrow()),
                    const SizedBox(height: 16),
                    Text(title, style: AppText.display(Responsive.pick<double>(context, mobile: 38, tablet: 52, desktop: 68))),
                    if (subtitle != null) ...[
                      const SizedBox(height: 18),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 620),
                        child: Text(subtitle!, style: AppText.body(color: const Color(0xFFC9CDC9))),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
