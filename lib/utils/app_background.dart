import 'package:flutter/material.dart';

class GradientBlob {
  final Color color;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final double size;

  GradientBlob({
    required this.color,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.size = 280,
  });
}

class DecorativeDot {
  final Color color;
  final double size;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;

  DecorativeDot({
    required this.color,
    required this.size,
    this.top,
    this.bottom,
    this.left,
    this.right,
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
    // Default blobs and dots if not provided
    final defaultBlobs = blobs ?? [
      GradientBlob(color: const Color(0xFFEDF046), top: -100, right: -80),
      GradientBlob(color: const Color(0xFF46F080), top: 86, left: -100),
      GradientBlob(color: const Color(0xFF2555FF), top: 232, right: -100),
      GradientBlob(color: const Color(0xFF46BDF0), top: 354, left: -70),
    ];

    final defaultDots = dots ?? [
      DecorativeDot(color: Color(0xFF92DEFF), size: 8, top: 73, left: 252),
      DecorativeDot(color: Color(0xFFBE9FFF), size: 4, top: 92, left: 202),
      DecorativeDot(color: Color(0xFF7FFCAA), size: 4, top: 362, left: 281),
      DecorativeDot(color:Color(0xFFEAED2A), size: 8, top: 383, left: 250),
      DecorativeDot(color: Color(0xFFA4E7F9), size: 4, top: 405, left: 176),
      DecorativeDot(color: Color(0xFFFFD7E4), size: 8, top: 391, left: 138),
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
        children: [
          // Render blobs in order
          ...defaultBlobs.map((blob) {
            return Positioned(
              top: blob.top,
              left: blob.left,
              bottom: blob.bottom,
              right: blob.right,
              child: _gradientBlob(blob.color, blob.size),
            );
          }).toList(),

          // Render dots in order
          ...defaultDots.map((dot) {
            return Positioned(
              top: dot.top,
              bottom: dot.bottom,
              left: dot.left,
              right: dot.right,
              child: _dot(dot.color, dot.size),
            );
          }).toList(),

          // PAGE CONTENT
          Positioned.fill(child: child),
        ],
      ),
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

  /// DECORATIVE DOT
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