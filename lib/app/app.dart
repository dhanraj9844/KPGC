import 'package:flutter/material.dart';

import '../config/site_config.dart';
import 'router.dart';
import 'theme/app_theme.dart';

class KpgcApp extends StatelessWidget {
  const KpgcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '${SiteConfig.companyName} | Royal Woods, Ahilyanagar',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: appRouter,
    );
  }
}
