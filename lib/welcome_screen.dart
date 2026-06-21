import 'package:flutter/material.dart';
import 'constants.dart';
import 'components.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: GraphicBackgroundPainter(),
            ),
          ),
          SafeArea(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Spacer(flex: 2),
                  Hero(
                    tag: 'logo',
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: kPrimaryColor.withOpacity(0.15),
                            blurRadius: 30,
                            offset: const Offset(0, 15),
                          )
                        ],
                      ),
                      child: ShaderMask(
                        shaderCallback: (bounds) => kPrimaryGradient.createShader(bounds),
                        child: const Icon(
                          Icons.chat_bubble_rounded,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Smart Chat',
                    textAlign: TextAlign.center,
                    style: kTitleTextStyle,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'The most elegant way to stay connected with your friends and community.',
                    textAlign: TextAlign.center,
                    style: kSubTitleTextStyle,
                  ),
                  const Spacer(flex: 3),
                  RoundedButton(
                    title: 'Get Started',
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                  const SizedBox(height: 16),
                  OutlinedRoundedButton(
                    title: 'Create Account',
                    onPressed: () {
                      Navigator.pushNamed(context, '/registration');
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GraphicBackgroundPainter extends CustomPainter {
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
