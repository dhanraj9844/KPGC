import 'package:flutter_test/flutter_test.dart';
import 'package:kpgc_ventures_website/config/site_config.dart';

void main() {
  test('business details are configured', () {
    expect(SiteConfig.phoneDisplay, '+91 74987 35188');
    expect(SiteConfig.whatsappNumber, '917498735188');
  });
}
