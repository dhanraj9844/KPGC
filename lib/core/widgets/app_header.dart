import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../constants/app_constants.dart';
import '../utils/responsive_helper.dart';
import 'kpgc_logo.dart';
import 'primary_button.dart';

bool isNavActive(NavItem item, String current) =>
    item.path == '/' ? current == '/' : current.startsWith(item.path);

class AppHeader extends StatelessWidget {
  const AppHeader({super.key, required this.path, required this.solid, required this.onMenu});

  final String path;
  final bool solid;
  final VoidCallback onMenu;

  @override
  Widget build(BuildContext context) {
    final desktop = Responsive.isDesktop(context);
    final mobile = Responsive.isMobile(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: solid ? AppColors.forest : Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: Responsive.hPad(context), vertical: mobile ? 12 : 16),
      child: Row(
        children: [
          KpgcLogo(compact: mobile),
          const Spacer(),
          if (desktop)
            for (final item in AppConstants.navItems)
              _NavLink(item: item, active: isNavActive(item, path)),
          if (!mobile) ...[
            SizedBox(width: desktop ? 20 : 12),
            PrimaryButton(label: 'Enquire Now', onPressed: () => context.go('/contact')),
          ],
          if (!desktop)
            IconButton(
              tooltip: 'Open menu',
              onPressed: onMenu,
              icon: const Icon(Icons.menu_rounded, color: AppColors.white, size: 28),
            ),
        ],
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink({required this.item, required this.active});

  final NavItem item;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.go(item.path),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        foregroundColor: active ? AppColors.gold : const Color(0xFFDDDDDD),
        overlayColor: Colors.transparent,
      ),
      child: Container(
        padding: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: active ? AppColors.gold : Colors.transparent, width: 1.5)),
        ),
        child: Text(item.label, style: AppText.body(size: 13, color: active ? AppColors.gold : const Color(0xFFDDDDDD), weight: FontWeight.w500, height: 1.2)),
      ),
    );
  }
}

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    void go(String to) {
      Navigator.of(context).pop();
      context.go(to);
    }

    return Drawer(
      backgroundColor: AppColors.forest,
      shape: const RoundedRectangleBorder(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  tooltip: 'Close menu',
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close_rounded, color: AppColors.white),
                ),
              ),
              for (final item in AppConstants.navItems)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () => go(item.path),
                  title: Text(item.label,
                      style: AppText.display(26, color: isNavActive(item, path) ? AppColors.gold : AppColors.white)),
                ),
              const Spacer(),
              PrimaryButton(label: 'Enquire Now', onPressed: () => go('/contact')),
            ],
          ),
        ),
      ),
    );
  }
}
