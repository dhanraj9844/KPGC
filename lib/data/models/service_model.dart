class ServiceModel {
  const ServiceModel({
    required this.title,
    required this.description,
    required this.benefits,
    required this.image,
  });

  final String title;
  final String description;
  final List<String> benefits;
  final String image;
}
