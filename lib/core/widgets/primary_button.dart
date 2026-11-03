import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.outlined = false,
    this.onDark = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool outlined;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final common = ButtonStyle(
      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 28, vertical: 20)),
      shape: WidgetStateProperty.all<OutlinedBorder>(const RoundedRectangleBorder()),
      textStyle: WidgetStateProperty.all(AppText.button),
      elevation: WidgetStateProperty.all(0),
    );
    bool hovered(Set<WidgetState> s) => s.contains(WidgetState.hovered);

    if (!outlined) {
      return FilledButton(
        onPressed: onPressed,
        style: common.copyWith(
          backgroundColor: WidgetStateProperty.resolveWith((s) {
            if (s.contains(WidgetState.disabled)) return AppColors.lightGrey;
            return hovered(s) ? (onDark ? AppColors.white : AppColors.forest) : AppColors.gold;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((s) =>
              hovered(s) && !onDark ? AppColors.white : AppColors.forest),
        ),
        child: Text(label.toUpperCase()),
      );
    }
    final base = onDark ? AppColors.white : AppColors.forest;
    final accent = onDark ? AppColors.gold : AppColors.forest;
    return OutlinedButton(
      onPressed: onPressed,
      style: common.copyWith(
        side: WidgetStateProperty.all(BorderSide(color: accent)),
        backgroundColor: WidgetStateProperty.resolveWith(
            (s) => hovered(s) ? accent : Colors.transparent),
        foregroundColor: WidgetStateProperty.resolveWith((s) =>
            hovered(s) ? (onDark ? AppColors.forest : AppColors.white) : base),
      ),
      child: Text(label.toUpperCase()),
    );
  }
}
