import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/about/pages/about_page.dart';
import '../features/contact/pages/contact_page.dart';
import '../features/gallery/pages/gallery_page.dart';
import '../features/home/pages/home_page.dart';
import '../features/legal/pages/legal_page.dart';
import '../features/projects/pages/projects_page.dart';
import '../features/projects/pages/royal_woods_page.dart';
import '../features/services/pages/services_page.dart';

CustomTransitionPage<void> _fade(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 350),
    transitionsBuilder: (context, animation, secondary, child) => FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
      child: child,
    ),
  );
}

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', pageBuilder: (c, s) => _fade(s, const HomePage())),
    GoRoute(path: '/about', pageBuilder: (c, s) => _fade(s, const AboutPage())),
    GoRoute(
      path: '/projects',
      pageBuilder: (c, s) => _fade(s, const ProjectsPage()),
      routes: [
        GoRoute(
          path: 'royal-woods',
          pageBuilder: (c, s) => _fade(s, const RoyalWoodsPage()),
        ),
      ],
    ),
    GoRoute(path: '/services', pageBuilder: (c, s) => _fade(s, const ServicesPage())),
    GoRoute(path: '/gallery', pageBuilder: (c, s) => _fade(s, const GalleryPage())),
    GoRoute(path: '/contact', pageBuilder: (c, s) => _fade(s, const ContactPage())),
    GoRoute(path: '/privacy', pageBuilder: (c, s) => _fade(s, const LegalPage(kind: LegalKind.privacy))),
    GoRoute(path: '/terms', pageBuilder: (c, s) => _fade(s, const LegalPage(kind: LegalKind.terms))),
  ],
  errorPageBuilder: (c, s) => _fade(s, const HomePage()),
);
