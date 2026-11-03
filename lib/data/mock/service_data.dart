import '../../config/image_config.dart';
import '../models/service_model.dart';

/// TODO: confirm this list with KPGC before launch.
class ServiceData {
  ServiceData._();

  static const List<ServiceModel> services = [
    ServiceModel(
      title: 'Real Estate Development',
      description:
          'Residential developments planned around how people live, from site selection and design coordination to delivery.',
      benefits: ['Thoughtful planning', 'Clear communication', 'Focus on long-term value'],
      image: ImageConfig.royalWoodsNight,
    ),
    ServiceModel(
      title: 'Residential Construction',
      description:
          'Quality-focused construction of apartments and homes, with careful attention to workmanship and detail.',
      benefits: ['Quality-focused workmanship', 'Transparent process', 'Dependable coordination'],
      image: ImageConfig.royalWoodsDay,
    ),
    ServiceModel(
      title: 'Construction Management',
      description:
          'Supervision and coordination of construction work so that schedules, quality and communication stay on track.',
      benefits: ['Organised site coordination', 'Regular updates', 'Single point of contact'],
      image: ImageConfig.royalWoodsGate,
    ),
    ServiceModel(
      title: 'Building Contracting',
      description:
          'Contracting services for residential buildings, delivered with a disciplined approach to quality and timelines.',
      benefits: ['Clear scope and responsibilities', 'Consistent standards', 'Responsive support'],
      image: ImageConfig.royalWoodsNight,
    ),
    ServiceModel(
      title: 'Project Planning & Coordination',
      description:
          'Planning support that brings design, approvals, materials and teams together before and during construction.',
      benefits: ['Fewer surprises', 'Better coordination', 'Practical guidance'],
      image: ImageConfig.royalWoodsDay,
    ),
  ];
}
