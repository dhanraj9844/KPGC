class NavItem {
  const NavItem(this.label, this.path);
  final String label;
  final String path;
}

class AppConstants {
  AppConstants._();

  static const navItems = <NavItem>[
    NavItem('Home', '/'),
    NavItem('About Us', '/about'),
    NavItem('Projects', '/projects'),
    NavItem('Services', '/services'),
    NavItem('Gallery', '/gallery'),
    NavItem('Contact', '/contact'),
  ];

  static const enquiryTypes = <String>[
    'General Enquiry',
    'Site Visit',
    'Brochure Request',
    'Floor Plan Request',
    'Project Details',
  ];

  static const contactTimes = <String>['Morning', 'Afternoon', 'Evening'];
}
