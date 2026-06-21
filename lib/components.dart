import 'package:flutter/material.dart';
import 'constants.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.color,
  });

  final Color? color;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: kPrimaryGradient,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: kModernShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            constraints: const BoxConstraints(minHeight: 60.0),
            alignment: Alignment.center,
            child: Text(
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
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: kPrimaryColor, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        minimumSize: const Size(double.infinity, 60),
      ),
      child: Text(
        title,
        style: kButtonTextStyle.copyWith(color: kPrimaryColor),
      ),
    );
  }
}

class ModernBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    // Top-left organic shape
    paint.color = kPrimaryColor.withOpacity(0.06);
    var path1 = Path();
    path1.moveTo(0, size.height * 0.2);
    path1.quadraticBezierTo(size.width * 0.3, size.height * 0.3, size.width * 0.4, 0);
    path1.lineTo(0, 0);
    path1.close();
    canvas.drawPath(path1, paint);

    // Bottom-right organic shape
    paint.color = kAccentColor.withOpacity(0.04);
    var path2 = Path();
    path2.moveTo(size.width, size.height * 0.7);
    path2.quadraticBezierTo(size.width * 0.6, size.height * 0.8, size.width * 0.5, size.height);
    path2.lineTo(size.width, size.height);
    path2.close();
    canvas.drawPath(path2, paint);

    // Soft glow circle
    paint.color = kPrimaryColor.withOpacity(0.03);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.3), size.width * 0.4, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
