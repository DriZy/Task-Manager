import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'soft_slope_button_shape.dart';

class StyledButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final Size? minimumSize;
  final BorderSide? side;
  final ButtonStyle? style;

  // Shape controls
  final double slopeDepth;
  final double sideRadius;
  final bool useSoftSlopeShape;

  const StyledButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.padding,
    this.textStyle,
    this.minimumSize,
    this.side,
    this.style,
    this.slopeDepth = 8,
    this.sideRadius = 16,
    this.useSoftSlopeShape = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color resolvedBg =
        backgroundColor ?? AppTheme.iconBgLavender;

    final Color resolvedFg =
        foregroundColor ?? AppTheme.lavender;

    final OutlinedBorder shape = useSoftSlopeShape
        ? SoftSlopeButtonShape(
            slopeDepth: slopeDepth,
            sideRadius: sideRadius,
            borderSide: side ?? BorderSide.none,
          )
        : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(sideRadius),
            side: side ?? BorderSide.none,
          );

    final ButtonStyle baseStyle = ElevatedButton.styleFrom(
      backgroundColor: resolvedBg,
      foregroundColor: resolvedFg,
      elevation: elevation ?? 0,
      minimumSize: minimumSize,
      padding: padding ??
          const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
      shape: shape,
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: baseStyle.merge(style),
      child: Text(
        text,
        style: (textStyle ?? AppTheme.bodyStyle).copyWith(
          fontSize: textStyle?.fontSize ?? 14,
          fontWeight: textStyle?.fontWeight ?? FontWeight.w600,
          color: textStyle?.color ?? resolvedFg,
        ),
      ),
    );
  }
}