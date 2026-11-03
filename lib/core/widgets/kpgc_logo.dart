import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/theme/app_colors.dart';

/// Text-based monogram. Replace with the official logo file when supplied.
class KpgcLogo extends StatelessWidget {
  const KpgcLogo({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go('/'),
        child: Semantics(
          button: true,
          label: 'KPGC Ventures home',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomPaint(size: const Size(26, 11), painter: _RoofPainter()),
              const SizedBox(height: 2),
              Text('KPGC',
                  style: GoogleFonts.manrope(
                      fontSize: compact ? 20 : 24, letterSpacing: 3, fontWeight: FontWeight.w600, color: AppColors.white, height: 1)),
              const SizedBox(height: 3),
              Text('VENTURES PVT LTD',
                  style: GoogleFonts.manrope(fontSize: 7.5, letterSpacing: 2.4, color: AppColors.gold, height: 1)),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoofPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.white
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset.zero, Offset(size.width * 0.55, 0), p);
    final path = Path()
      ..moveTo(size.width * 0.15, size.height)
      ..lineTo(size.width * 0.5, size.height * 0.2)
      ..lineTo(size.width * 0.85, size.height);
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
