import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/site_config.dart';

/// All outgoing links. Failures show a friendly message instead of crashing.
class UrlHelper {
  UrlHelper._();

  static Future<void> _open(BuildContext context, Uri uri) async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    try {
      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!ok) _fail(messenger);
    } catch (_) {
      _fail(messenger);
    }
  }

  static void _fail(ScaffoldMessengerState? m) {
    m?.showSnackBar(const SnackBar(
      content: Text('Could not open the link. Please call +91 74987 35188.'),
    ));
  }

  static Future<void> call(BuildContext context) =>
      _open(context, Uri(scheme: 'tel', path: SiteConfig.phoneE164));

  static Future<void> email(BuildContext context) async {
    final mail = SiteConfig.email;
    if (mail == null) {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(const SnackBar(
        content: Text('Email address will be available soon. Please call or use WhatsApp.'),
      ));
      return;
    }
    await _open(context, Uri(scheme: 'mailto', path: mail));
  }

  static Future<void> whatsapp(BuildContext context, {String? message}) {
    final text = Uri.encodeComponent(message ?? SiteConfig.whatsappMessage);
    return _open(context, Uri.parse('https://wa.me/${SiteConfig.whatsappNumber}?text=$text'));
  }

  static Future<void> maps(BuildContext context) {
    final q = Uri.encodeComponent(SiteConfig.fullAddress);
    return _open(context, Uri.parse('https://www.google.com/maps/search/?api=1&query=$q'));
  }

  static Future<void> external(BuildContext context, String url) =>
      _open(context, Uri.parse(url));
}
