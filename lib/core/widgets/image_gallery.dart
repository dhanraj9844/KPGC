import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';

class GalleryItem {
  const GalleryItem(this.asset, this.caption, this.category);
  final String asset;
  final String caption;
  final String category;
}

/// Thumbnail with hover zoom; opens the lightbox.
class GalleryTile extends StatefulWidget {
  const GalleryTile({super.key, required this.items, required this.index, this.aspect = 4 / 3});

  final List<GalleryItem> items;
  final int index;
  final double aspect;

  @override
  State<GalleryTile> createState() => _GalleryTileState();
}

class _GalleryTileState extends State<GalleryTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.items[widget.index];
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () => ImageGallery.show(context, widget.items, widget.index),
        child: Semantics(
          button: true,
          label: 'Open image: ${item.caption}',
          child: AspectRatio(
            aspectRatio: widget.aspect,
            child: ClipRect(
              child: Stack(fit: StackFit.expand, children: [
                AnimatedScale(
                  scale: _hover ? 1.05 : 1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                  child: Image.asset(item.asset, fit: BoxFit.cover, cacheWidth: 900),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [Color(0xCC000000), Color(0x00000000)]),
                    ),
                    child: Text(item.caption, style: AppText.body(size: 12, color: AppColors.white)),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageGallery {
  ImageGallery._();

  static Future<void> show(BuildContext context, List<GalleryItem> items, int index) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) => _Lightbox(items: items, start: index),
    );
  }
}

class _Lightbox extends StatefulWidget {
  const _Lightbox({required this.items, required this.start});

  final List<GalleryItem> items;
  final int start;

  @override
  State<_Lightbox> createState() => _LightboxState();
}

class _LightboxState extends State<_Lightbox> {
  late final PageController _page = PageController(initialPage: widget.start);
  late int _current = widget.start;

  void _go(int delta) {
    final n = (_current + delta).clamp(0, widget.items.length - 1);
    _page.animateToPage(n, duration: const Duration(milliseconds: 350), curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _page.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Colors.black.withValues(alpha: 0.94),
      child: Focus(
        autofocus: true,
        onKeyEvent: (node, event) {
          if (event is! KeyDownEvent) return KeyEventResult.ignored;
          if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            _go(1);
            return KeyEventResult.handled;
          }
          if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            _go(-1);
            return KeyEventResult.handled;
          }
          if (event.logicalKey == LogicalKeyboardKey.escape) {
            Navigator.of(context).pop();
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
        child: Stack(children: [
          PageView.builder(
            controller: _page,
            itemCount: widget.items.length,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (_, i) => InteractiveViewer(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(64, 72, 64, 72),
                child: Image.asset(widget.items[i].asset, fit: BoxFit.contain),
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: IconButton(tooltip: 'Close', onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close_rounded, color: AppColors.white, size: 30)),
          ),
          Positioned(
            left: 8,
            top: 0,
            bottom: 0,
            child: Center(child: IconButton(tooltip: 'Previous image', onPressed: _current > 0 ? () => _go(-1) : null, icon: const Icon(Icons.chevron_left_rounded, color: AppColors.white, size: 40))),
          ),
          Positioned(
            right: 8,
            top: 0,
            bottom: 0,
            child: Center(child: IconButton(tooltip: 'Next image', onPressed: _current < widget.items.length - 1 ? () => _go(1) : null, icon: const Icon(Icons.chevron_right_rounded, color: AppColors.white, size: 40))),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 24,
            child: Text('${widget.items[_current].caption}  ·  ${_current + 1} / ${widget.items.length}', textAlign: TextAlign.center, style: AppText.body(size: 13, color: Colors.white70)),
          ),
        ]),
      ),
    );
  }
}
