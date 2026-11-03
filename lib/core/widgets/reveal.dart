import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Subtle entrance animation. Skipped when the user prefers reduced motion.
class Reveal extends StatelessWidget {
  const Reveal({super.key, required this.child, this.delay = Duration.zero});

  final Widget child;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).disableAnimations) return child;
    return child
        .animate(delay: delay)
        .fadeIn(duration: 700.ms, curve: Curves.easeOut)
        .slideY(begin: 0.06, end: 0, duration: 700.ms, curve: Curves.easeOut);
  }
}
