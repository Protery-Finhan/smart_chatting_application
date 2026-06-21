import 'package:flutter/material.dart';
import 'constants.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.gradient,
    this.isLoading = false,
  });

  final String title;
  final VoidCallback onPressed;
  final Gradient? gradient;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: gradient ?? kPrimaryGradient,
        borderRadius: BorderRadius.circular(kDefaultRadius),
        boxShadow: kModernShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(kDefaultRadius),
          child: Container(
            constraints: const BoxConstraints(minHeight: 56.0),
            alignment: Alignment.center,
            child: isLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : Text(
                    title,
                    style: kButtonTextStyle,
                  ),
          ),
        ),
      ),
    );
  }
}

class OutlinedRoundedButton extends StatelessWidget {
  const OutlinedRoundedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.color,
  });

  final String title;
  final VoidCallback onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color ?? kPrimaryColor, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultRadius),
        ),
        minimumSize: const Size(double.infinity, 56),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Text(
        title,
        style: kButtonTextStyle.copyWith(color: color ?? kPrimaryColor),
      ),
    );
  }
}

class ModernCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  const ModernCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(kDefaultRadius),
        boxShadow: kSoftShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(kDefaultRadius),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(kDefaultPadding),
            child: child,
          ),
        ),
      ),
    );
  }
}

class ModernBackgroundPainter extends CustomPainter {
  const ModernBackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    // Top-left soft gradient blob
    paint.color = kPrimaryColor.withValues(alpha: 0.05);
    canvas.drawCircle(Offset(size.width * 0.1, size.height * 0.1), size.width * 0.4, paint);

    // Bottom-right soft gradient blob
    paint.color = kAccentColor.withValues(alpha: 0.04);
    canvas.drawCircle(Offset(size.width * 0.9, size.height * 0.9), size.width * 0.5, paint);

    // Subtle floating circle
    paint.color = kPrimaryColor.withValues(alpha: 0.02);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.2), size.width * 0.2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
