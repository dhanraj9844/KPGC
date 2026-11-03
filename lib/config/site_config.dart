/// Central business details. Edit here only.
class SiteConfig {
  SiteConfig._();

  static const companyName = 'KPGC Ventures Pvt. Ltd.';
  static const tagline = 'Building Spaces. Creating Legacies.';
  static const phoneDisplay = '+91 74987 35188';
  static const phoneE164 = '+917498735188';
  static const whatsappNumber = '917498735188';

  /// TODO: confirm the official email address, then set it here.
  static const String? email = null;

  static const fullAddress =
      'Anuron 7 Road, Behind DMart, Nandanvan Nagar, Ahilyanagar, Maharashtra 414003';

  /// TODO: replace with the production domain (also in web/index.html, robots.txt, sitemap.xml).
  static const siteUrl = 'https://www.your-domain.com';

  static const pending = 'Contact us for current details';

  static const whatsappMessage =
      'Hello KPGC Ventures, I would like to know more about the Royal Woods project in Ahilyanagar. Please share the latest project details.';

  static String messageFor(String request) =>
      'Hello KPGC Ventures, I would like to $request for the Royal Woods project in Ahilyanagar. Please share the latest details.';
}
