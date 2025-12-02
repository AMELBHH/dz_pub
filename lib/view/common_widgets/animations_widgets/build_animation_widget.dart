// // lib/animations/animate_factory.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:visibility_detector/visibility_detector.dart';
//
// /// Factory that builds a repeated Animate instance with default timing.
// ///
// /// You must pass the [child] widget (usually a container).
//
// Animate buildAnimatedWidget( {
//   required Widget child,
//   Duration totalDuration = const Duration(milliseconds: 1125),
//   Duration effectDelay = const Duration(milliseconds: 375),
//   Duration effectDuration = const Duration(milliseconds: 750),
// }) {
//   return child
//       .animate()
//       .effect(duration: totalDuration) // Pads out the duration
//       .effect(delay: effectDelay, duration: effectDuration); // Default effect timing
// }
//
//
// // file: build_animation_widget.dart
//
//
//
// enum SlideDirection { x, y, xy }
//
// class FadeInOnVisible extends StatefulWidget {
//   final Widget child;
//   final SlideDirection direction;
//   final Duration? delay;
//
//   const FadeInOnVisible({
//     super.key,
//     required this.child,
//     this.direction = SlideDirection.xy,
//     this.delay,
//   });
//
//   @override
//   State<FadeInOnVisible> createState() => _FadeInOnVisibleState();
// }
//
// class _FadeInOnVisibleState extends State<FadeInOnVisible> {
//   bool _visible = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return VisibilityDetector(
//       key: widget.key ?? UniqueKey(),
//       onVisibilityChanged: (info) {
//         if (!_visible && info.visibleFraction > .5) {
//           setState(() => _visible = true);
//         }
//       },
//       child: _visible
//           ? _animatedWidget(widget.child)
//           : Opacity(opacity: 0, child: widget.child),
//     );
//   }
//
//   Widget _animatedWidget(Widget child) {
//     final animate = child.animate().fadeIn(duration: 700.ms,delay:widget
//         .delay );
//
//     switch (widget.direction) {
//       case SlideDirection.x:
//         return animate.slideX(duration: 700.ms, curve: Curves.easeOutCubic);
//       case SlideDirection.y:
//         return animate.slideY(duration: 700.ms, curve: Curves.easeOutCubic);
//       case SlideDirection.xy:
//         return animate.slide(duration: 700.ms, curve: Curves.easeOutCubic);
//     }
//   }
// }