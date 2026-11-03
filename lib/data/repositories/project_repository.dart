import '../mock/project_data.dart';
import '../models/project_model.dart';

/// Swap the mock data for an API or CMS here later.
class ProjectRepository {
  ProjectRepository._();

  static List<ProjectModel> all() => ProjectData.projects;

  static List<ProjectModel> byStatus(ProjectStatus s) =>
      all().where((p) => p.status == s).toList();

  static ProjectModel get featured => all().first;

  static ProjectModel? bySlug(String slug) {
    for (final p in all()) {
      if (p.slug == slug) return p;
    }
    return null;
  }
}
