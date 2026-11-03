import 'package:flutter/material.dart';

import '../utils/responsive_helper.dart';

/// Centres content with a max width and responsive side padding.
class ResponsiveContainer extends StatelessWidget {
  const ResponsiveContainer({super.key, required this.child, this.maxWidth = 1240});

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final pad = Responsive.hPad(context);
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth + pad * 2),
        child: Padding(padding: EdgeInsets.symmetric(horizontal: pad), child: child),
      ),
    );
  }
}

/// Full-width band with background colour and vertical rhythm.
class Section extends StatelessWidget {
  const Section({super.key, required this.child, this.background, this.vertical});

  final Widget child;
  final Color? background;
  final double? vertical;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: background,
      padding: EdgeInsets.symmetric(vertical: vertical ?? Responsive.vPad(context)),
      child: ResponsiveContainer(child: child),
    );
  }
}

/// Two columns on desktop, stacked below [stackBelow].
class SplitLayout extends StatelessWidget {
  const SplitLayout({
    super.key,
    required this.left,
    required this.right,
    this.leftFlex = 1,
    this.rightFlex = 1,
    this.gap = 72,
    this.crossAxis = CrossAxisAlignment.center,
    this.stackBelow = 1024,
  });

  final Widget left;
  final Widget right;
  final int leftFlex;
  final int rightFlex;
  final double gap;
  final CrossAxisAlignment crossAxis;
  final double stackBelow;

  @override
  Widget build(BuildContext context) {
    if (Responsive.width(context) >= stackBelow) {
      return Row(
        crossAxisAlignment: crossAxis,
        children: [
          Expanded(flex: leftFlex, child: left),
          SizedBox(width: gap),
          Expanded(flex: rightFlex, child: right),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [left, const SizedBox(height: 40), right],
    );
  }
}

/// Equal-width responsive columns (no overflow on any screen).
class ColumnsWrap extends StatelessWidget {
  const ColumnsWrap({
    super.key,
    required this.children,
    this.desktop = 4,
    this.tablet = 2,
    this.mobile = 1,
    this.gap = 32,
  });

  final List<Widget> children;
  final int desktop;
  final int tablet;
  final int mobile;
  final double gap;

  @override
  Widget build(BuildContext context) {
    final cols = Responsive.pick<int>(context, mobile: mobile, tablet: tablet, desktop: desktop);
    return LayoutBuilder(builder: (context, c) {
      final w = (c.maxWidth - gap * (cols - 1)) / cols;
      return Wrap(
        spacing: gap,
        runSpacing: gap,
        children: [for (final ch in children) SizedBox(width: w, child: ch)],
      );
    });
  }
}
