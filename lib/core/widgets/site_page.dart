import 'package:flutter/material.dart';

import 'app_footer.dart';
import 'app_header.dart';
import 'whatsapp_button.dart';

/// Shared page frame: sticky header, scrolling body, footer, WhatsApp button.
class SitePage extends StatefulWidget {
  const SitePage({super.key, required this.path, required this.body});

  final String path;
  final Widget body;

  @override
  State<SitePage> createState() => _SitePageState();
}

class _SitePageState extends State<SitePage> {
  final _scroll = ScrollController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _solid = false;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      final s = _scroll.offset > 40;
      if (s != _solid) setState(() => _solid = s);
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: MobileDrawer(path: widget.path),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scroll,
              child: Column(children: [widget.body, const AppFooter()]),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppHeader(path: widget.path, solid: _solid, onMenu: () => _scaffoldKey.currentState?.openEndDrawer()),
          ),
          const Positioned(right: 16, bottom: 16, child: WhatsAppButton()),
        ],
      ),
    );
  }
}
