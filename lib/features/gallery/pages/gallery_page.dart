import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../config/image_config.dart';
import '../../../core/widgets/image_gallery.dart';
import '../../../core/widgets/page_banner.dart';
import '../../../core/widgets/responsive_container.dart';
import '../../../core/widgets/site_page.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  static const _categories = ['All', 'Architecture', 'Exterior', 'Interiors', 'Construction Progress', 'Project Details'];

  /// Only real project visuals are listed. Add real photographs here and
  /// tag them with the right category. Never label stock images as progress.
  static const _all = <GalleryItem>[
    GalleryItem(ImageConfig.royalWoodsNight, 'Royal Woods, architectural render', 'Architecture'),
    GalleryItem(ImageConfig.royalWoodsDay, 'Royal Woods, architectural render', 'Exterior'),
    GalleryItem(ImageConfig.royalWoodsGate, 'Royal Woods entrance, architectural render', 'Exterior'),
  ];

  String _category = 'All';

  @override
  Widget build(BuildContext context) {
    final items = _category == 'All' ? _all : _all.where((i) => i.category == _category).toList();
    return SitePage(
      path: '/gallery',
      body: Column(children: [
        const PageBanner(eyebrow: 'Gallery', title: 'Project Gallery', subtitle: 'Architectural visuals of Royal Woods.'),
        Section(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Wrap(spacing: 8, runSpacing: 8, children: [
              for (final c in _categories)
                ChoiceChip(
                  label: Text(c, style: AppText.body(size: 13, color: _category == c ? AppColors.white : AppColors.forest, weight: FontWeight.w600)),
                  selected: _category == c,
                  showCheckmark: false,
                  selectedColor: AppColors.forest,
                  backgroundColor: AppColors.white,
                  shape: const RoundedRectangleBorder(side: BorderSide(color: AppColors.forest)),
                  onSelected: (_) => setState(() => _category = c),
                ),
            ]),
            const SizedBox(height: 40),
            if (items.isEmpty)
              Text('Photographs for this category will be added soon.', style: AppText.body(color: AppColors.secondaryText))
            else
              ColumnsWrap(desktop: 3, tablet: 2, mobile: 1, gap: 20, children: [
                for (var i = 0; i < items.length; i++) GalleryTile(items: items, index: i),
              ]),
          ]),
        ),
      ]),
    );
  }
}
