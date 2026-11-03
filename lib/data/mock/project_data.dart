import '../../config/image_config.dart';
import '../../config/site_config.dart';
import '../models/project_model.dart';

class ProjectData {
  ProjectData._();

  static const List<ProjectModel> projects = [
    ProjectModel(
      slug: 'royal-woods',
      name: 'Royal Woods',
      subtitle: 'Contemporary Living in Ahilyanagar.',
      developer: SiteConfig.companyName,
      location: 'Ahilyanagar, Maharashtra',
      address: SiteConfig.fullAddress,
      shortDescription:
          'A residential development by KPGC Ventures Pvt. Ltd. on Anuron 7 Road, Nandanvan Nagar.',
      // TODO: confirm status with KPGC before launch.
      status: ProjectStatus.ongoing,
      coverImage: ImageConfig.royalWoodsGate,
      gallery: [
        ImageConfig.royalWoodsNight,
        ImageConfig.royalWoodsDay,
        ImageConfig.royalWoodsGate,
      ],
      // Add ONLY after verification with the developer:
      // configurations, reraNumber, possession, amenities, specifications.
    ),
  ];
}
