import 'package:flutter/material.dart';

class SoftSlopeButtonShape extends OutlinedBorder {
  final double slopeDepth;     // concave depth (top/bottom)
  final double sideRadius;     // left/right rounding

  const SoftSlopeButtonShape({
    this.slopeDepth = 8,
    this.sideRadius = 16,
    BorderSide borderSide = BorderSide.none,
  }) : super(side: borderSide);

  // Backward-compatible alias for older call sites.
  BorderSide get borderSide => side;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

  @override
  OutlinedBorder copyWith({BorderSide? side}) {
    return SoftSlopeButtonShape(
      slopeDepth: slopeDepth,
      sideRadius: sideRadius,
      borderSide: side ?? this.side,
    );
  }

  @override
  ShapeBorder scale(double t) {
    return SoftSlopeButtonShape(
      slopeDepth: slopeDepth * t,
      sideRadius: sideRadius * t,
      borderSide: side.scale(t),
    );
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();

    final double r = sideRadius.clamp(0.0, rect.height / 2);

    path.moveTo(rect.left + r, rect.top);

    // Top concave curve
    path.quadraticBezierTo(
      rect.center.dx,
      rect.top - slopeDepth,
      rect.right - r,
      rect.top,
    );

    // Right side arc
    path.arcToPoint(
      Offset(rect.right - r, rect.bottom),
      radius: Radius.circular(r),
      clockwise: true,
    );

    // Bottom concave curve
    path.quadraticBezierTo(
      rect.center.dx,
      rect.bottom + slopeDepth,
      rect.left + r,
      rect.bottom,
    );

    // Left side arc
    path.arcToPoint(
      Offset(rect.left + r, rect.top),
      radius: Radius.circular(r),
      clockwise: true,
    );

    path.close();
    return path;
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect.deflate(side.width));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (side != BorderSide.none) {
      final paint = side.toPaint();
      final path = getOuterPath(rect);
      canvas.drawPath(path, paint);
    }
  }
}