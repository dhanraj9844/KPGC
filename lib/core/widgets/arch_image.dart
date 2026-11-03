import 'package:flutter/material.dart';

/// Cropped image with a fixed aspect ratio.
class ArchImage extends StatelessWidget {
  const ArchImage(this.asset, {super.key, this.aspect = 4 / 5, this.alignment = Alignment.center, this.label});

  final String asset;
  final double aspect;
  final Alignment alignment;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      image: true,
      label: label ?? 'Royal Woods architectural render',
      child: AspectRatio(
        aspectRatio: aspect,
        child: ClipRect(
          child: Image.asset(asset, fit: BoxFit.cover, alignment: alignment, filterQuality: FilterQuality.high),
        ),
      ),
    );
  }
}
