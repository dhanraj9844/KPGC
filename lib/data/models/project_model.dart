enum ProjectStatus { ongoing, completed, upcoming }

class ProjectModel {
  const ProjectModel({
    required this.slug,
    required this.name,
    required this.subtitle,
    required this.developer,
    required this.location,
    required this.address,
    required this.shortDescription,
    required this.status,
    required this.coverImage,
    this.gallery = const [],
    this.configurations,
    this.reraNumber,
    this.possession,
    this.amenities = const [],
    this.specifications = const [],
  });

  final String slug;
  final String name;
  final String subtitle;
  final String developer;
  final String location;
  final String address;
  final String shortDescription;
  final ProjectStatus status;
  final String coverImage;
  final List<String> gallery;

  /// Leave null until verified with the developer. The UI then shows
  /// "Contact us for current details".
  final String? configurations;
  final String? reraNumber;
  final String? possession;
  final List<String> amenities;
  final List<String> specifications;

  String get statusLabel => switch (status) {
        ProjectStatus.ongoing => 'Ongoing',
        ProjectStatus.completed => 'Completed',
        ProjectStatus.upcoming => 'Upcoming',
      };
}
