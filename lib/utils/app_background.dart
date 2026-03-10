import 'package:flutter/material.dart';

class GradientBlob {
  final Color color;
  final double? topFraction;
  final double? leftFraction;
  final double? rightFraction;
  final double? bottomFraction;
  /// size as a fraction of screen width
  final double sizeFraction;

  GradientBlob({
    required this.color,
    this.topFraction,
    this.bottomFraction,
    this.leftFraction,
    this.rightFraction,
    this.sizeFraction = 0.75,
  });
}

class DecorativeDot {
  final Color color;
  final double sizePx;
  final double topFraction;
  final double leftFraction;

  DecorativeDot({
    required this.color,
    required this.sizePx,
    required this.topFraction,
    required this.leftFraction,
  });
}

class AppBackground extends StatelessWidget {
  final Widget child;
  final List<GradientBlob>? blobs;
  final List<DecorativeDot>? dots;

  const AppBackground({
    super.key,
    required this.child,
    this.blobs,
    this.dots,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final sw = constraints.maxWidth;
        final sh = constraints.maxHeight;

        final defaultBlobs = blobs ?? [
          GradientBlob(color: const Color(0xFFEDF046), topFraction: -0.12, rightFraction: -0.23),
          GradientBlob(color: const Color(0xFF46F080), topFraction: 0.07,  leftFraction:  -0.30),
          GradientBlob(color: const Color(0xFF2555FF), topFraction: 0.20,  rightFraction: -0.26),
          GradientBlob(color: const Color(0xFF46BDF0), topFraction: 0.42,  leftFraction:  -0.18),
        ];

        final defaultDots = dots ?? [
          DecorativeDot(color: const Color(0xFF92DEFF), sizePx: 8,  topFraction: 0.10, leftFraction: 0.62),
          DecorativeDot(color: const Color(0xFFBE9FFF), sizePx: 4,  topFraction: 0.13, leftFraction: 0.50),
          DecorativeDot(color: const Color(0xFF7FFCAA), sizePx: 4,  topFraction: 0.52, leftFraction: 0.70),
          DecorativeDot(color: const Color(0xFFEAED2A), sizePx: 8,  topFraction: 0.55, leftFraction: 0.62),
          DecorativeDot(color: const Color(0xFFA4E7F9), sizePx: 4,  topFraction: 0.58, leftFraction: 0.44),
          DecorativeDot(color: const Color(0xFFFFD7E4), sizePx: 8,  topFraction: 0.56, leftFraction: 0.35),
        ];

        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFEFF4F6),
                Color(0xFFF3EEF7),
                Color(0xFFF7F4E9),
              ],
            ),
          ),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              // Blobs
              ...defaultBlobs.map((blob) {
                final size = sw * blob.sizeFraction;
                final top    = blob.topFraction    != null ? sh * blob.topFraction!    : null;
                final bottom = blob.bottomFraction != null ? sh * blob.bottomFraction! : null;
                final left   = blob.leftFraction   != null ? sw * blob.leftFraction!   : null;
                final right  = blob.rightFraction  != null ? sw * blob.rightFraction!  : null;
                return Positioned(
                  top: top,
                  bottom: bottom,
                  left: left,
                  right: right,
                  child: _gradientBlob(blob.color, size),
                );
              }),

              // Dots
              ...defaultDots.map((dot) {
                return Positioned(
                  top: sh * dot.topFraction,
                  left: sw * dot.leftFraction,
                  child: _dot(dot.color, dot.sizePx),
                );
              }),

              // Page content always on top
              Positioned.fill(child: child),
            ],
          ),
        );
      },
    );
  }

  static Widget _gradientBlob(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            color.withValues(alpha: 0.35),
            color.withValues(alpha: 0.05),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  static Widget _dot(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}