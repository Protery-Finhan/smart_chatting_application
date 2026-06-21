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
              painter: ModernBackgroundPainter(),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        child: Column(
                          children: <Widget>[
                            const Spacer(flex: 2),
                            Hero(
                              tag: 'logo',
                              child: Container(
                                padding: const EdgeInsets.all(28),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: kModernShadow,
                                ),
                                child: ShaderMask(
                                  shaderCallback: (bounds) => kPrimaryGradient.createShader(bounds),
                                  child: const Icon(
                                    Icons.forum_rounded,
                                    size: 72,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 48),
                            const Text(
                              'XemOttah',
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
                            const SizedBox(height: 48),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
