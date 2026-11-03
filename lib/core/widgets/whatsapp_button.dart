import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../utils/responsive_helper.dart';
import '../utils/url_helper.dart';

class WhatsAppButton extends StatelessWidget {
  const WhatsAppButton({super.key});

  @override
  Widget build(BuildContext context) {
    final compact = Responsive.isMobile(context);
    return Semantics(
      button: true,
      label: 'Chat on WhatsApp',
      child: Material(
        color: const Color(0xFF25D366),
        elevation: 4,
        shape: const StadiumBorder(),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: () => UrlHelper.whatsapp(context),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: compact ? 16 : 22, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.chat_rounded, color: AppColors.white, size: 22),
                if (!compact) ...[
                  const SizedBox(width: 10),
                  Text('WhatsApp', style: AppText.body(size: 13, color: AppColors.white, weight: FontWeight.w700)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
