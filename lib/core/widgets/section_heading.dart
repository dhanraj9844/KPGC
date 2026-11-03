import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../utils/responsive_helper.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
    this.light = false,
    this.center = false,
  });

  final String eyebrow;
  final String title;
  final String? subtitle;
  final bool light;
  final bool center;

  @override
  Widget build(BuildContext context) {
    final size = Responsive.pick<double>(context, mobile: 28, tablet: 36, desktop: 44);
    return Column(
      crossAxisAlignment: center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(eyebrow.toUpperCase(), style: AppText.eyebrow(), textAlign: center ? TextAlign.center : TextAlign.start),
        const SizedBox(height: 14),
        Text(
          title,
          textAlign: center ? TextAlign.center : TextAlign.start,
          style: AppText.display(size, color: light ? AppColors.white : AppColors.forest),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 18),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Text(
              subtitle!,
              textAlign: center ? TextAlign.center : TextAlign.start,
              style: AppText.body(color: light ? const Color(0xFFC9CDC9) : AppColors.secondaryText),
            ),
          ),
        ],
      ],
    );
  }
}
