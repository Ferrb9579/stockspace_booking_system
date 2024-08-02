import 'package:flutter/material.dart';

class UButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color rippleColor;
  final Color backgroundColor;
  final Color foregroundColor;
  final double elevation;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Size? minimumSize;
  final Size? maximumSize;
  final double? width;
  final double? height;

  const UButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.rippleColor = const Color.fromARGB(0, 0, 0, 0),
    this.backgroundColor = Colors.blue,
    this.foregroundColor = Colors.white,
    this.elevation = 2.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.margin = EdgeInsets.zero,
    this.minimumSize,
    this.maximumSize,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Material(
        elevation: elevation,
        borderRadius: borderRadius,
        color: backgroundColor,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: minimumSize?.width ?? 0,
            minHeight: minimumSize?.height ?? 0,
            maxWidth: maximumSize?.width ?? double.infinity,
            maxHeight: maximumSize?.height ?? double.infinity,
          ),
          child: IntrinsicWidth(
            child: IntrinsicHeight(
              child: SizedBox(
                width: width,
                height: height,
                child: InkWell(
                  onTap: onPressed,
                  splashColor: rippleColor,
                  borderRadius: borderRadius,
                  child: Padding(
                    padding: padding,
                    child: DefaultTextStyle(
                      style: TextStyle(color: foregroundColor),
                      child: Center(child: child),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
