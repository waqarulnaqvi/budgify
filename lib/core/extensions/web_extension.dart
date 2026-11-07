// import 'dart:ui';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:true_heal_user/core/constants/app_breakpoints.dart';
//
// extension WebMaxWidthExtension on Widget {
//   Widget withWebMaxWidth({double maxWidth = AppBreakpoints.tablet}) {
//     if (!kIsWeb) return this;
//
//     return Builder(
//       builder: (context) {
//         final width = MediaQuery.of(context).size.width;
//
//         // Below the tablet breakpoint → behave exactly like normal, no frame.
//         if (width <= AppBreakpoints.tablet) {
//           return this;
//         }
//
//         final colorScheme = Theme.of(context).colorScheme;
//
//         // ✅ Card always takes 80% of the current screen width once triggered.
//         final cardWidth = width * 0.85;
//
//         return Container(
//           width: double.infinity,
//           height: double.infinity,
//           color: const Color(0xFFF6F7FB), // soft neutral canvas
//           child: Stack(
//             children: [
//               // ── Base ambient gradient wash ─────────────────────
//               Positioned.fill(
//                 child: DecoratedBox(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [
//                         colorScheme.primary.withValues(alpha: 0.06),
//                         const Color(0xFFF6F7FB),
//                         colorScheme.secondary.withValues(alpha: 0.05),
//                       ],
//                       stops: const [0.0, 0.5, 1.0],
//                     ),
//                   ),
//                 ),
//               ),
//
//               // ── Glowing blob — top left ────────────────────────
//               Positioned(
//                 top: -140,
//                 left: -120,
//                 child: _GlowBlob(
//                   size: 420,
//                   color: colorScheme.primary.withValues(alpha: 0.28),
//                 ),
//               ),
//
//               // ── Glowing blob — bottom right ────────────────────
//               Positioned(
//                 bottom: -160,
//                 right: -140,
//                 child: _GlowBlob(
//                   size: 460,
//                   color: colorScheme.secondary.withValues(alpha: 0.22),
//                 ),
//               ),
//
//               // ── Subtle radial vignette for depth ───────────────
//               Positioned.fill(
//                 child: DecoratedBox(
//                   decoration: BoxDecoration(
//                     gradient: RadialGradient(
//                       center: Alignment.center,
//                       radius: 1.1,
//                       colors: [
//                         Colors.transparent,
//                         Colors.black.withValues(alpha: 0.03),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//
//               // ── The premium card itself ────────────────────────
//               Center(
//                 child: Container(
//                   width: cardWidth,
//                   margin: const EdgeInsets.symmetric(vertical: 40),
//                   padding: const EdgeInsets.all(1.8),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(30),
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [
//                         colorScheme.primary.withValues(alpha: 0.65),
//                         Colors.white.withValues(alpha: 0.30),
//                         colorScheme.secondary.withValues(alpha: 0.55),
//                       ],
//                       stops: const [0.0, 0.5, 1.0],
//                     ),
//                     boxShadow: [
//                       // colored glow, matching the border gradient
//                       BoxShadow(
//                         color: colorScheme.primary.withValues(alpha: 0.22),
//                         blurRadius: 80,
//                         spreadRadius: -14,
//                         offset: const Offset(-10, 20),
//                       ),
//                       BoxShadow(
//                         color: colorScheme.secondary.withValues(alpha: 0.18),
//                         blurRadius: 80,
//                         spreadRadius: -14,
//                         offset: const Offset(10, 20),
//                       ),
//                       // grounding shadow
//                       BoxShadow(
//                         color: Colors.black.withValues(alpha: 0.06),
//                         blurRadius: 24,
//                         spreadRadius: -8,
//                         offset: const Offset(0, 10),
//                       ),
//                     ],
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(28.2),
//                     child: Container(
//                       color: Colors.white,
//                       child: Stack(
//                         children: [
//                           this,
//                           // faint inner highlight ring, glass-card feel
//                           Positioned.fill(
//                             child: IgnorePointer(
//                               child: DecoratedBox(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(28.2),
//                                   border: Border.all(
//                                     color: Colors.white.withValues(alpha: 0.6),
//                                     width: 1,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// /// Soft, blurred glowing circle used as a decorative background accent.
// class _GlowBlob extends StatelessWidget {
//   const _GlowBlob({required this.size, required this.color});
//
//   final double size;
//   final Color color;
//
//   @override
//   Widget build(BuildContext context) {
//     return ImageFiltered(
//       imageFilter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
//       child: Container(
//         width: size,
//         height: size,
//         decoration: BoxDecoration(shape: BoxShape.circle, color: color),
//       ),
//     );
//   }
//
//   Widget withWebConstraintWidth({double maxWidth = 1200}) {
//     if (!kIsWeb) return this;
//
//     return Center(
//       child: ConstrainedBox(
//         constraints: BoxConstraints(maxWidth: maxWidth),
//         child: this,
//       ),
//     );
//   }
// }
