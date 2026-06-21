import 'package:flutter/material.dart';
import 'constants.dart';
import 'components.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, top: 8),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: kTextPrimaryColor),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const SizedBox(height: 20),
                        Hero(
                          tag: 'logo',
                          child: ShaderMask(
                            shaderCallback: (bounds) => kPrimaryGradient.createShader(bounds),
                            child: const Icon(
                              Icons.forum_rounded,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        const Text(
                          'Welcome Back',
                          textAlign: TextAlign.center,
                          style: kHeadlineTextStyle,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Login to continue your conversations with the community.',
                          textAlign: TextAlign.center,
                          style: kSubTitleTextStyle,
                        ),
                        const SizedBox(height: 48.0),
                        TextField(
                          style: const TextStyle(color: kTextPrimaryColor, fontWeight: FontWeight.w600),
                          keyboardType: TextInputType.emailAddress,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Email',
                            prefixIcon: const Icon(Icons.email_outlined, color: kPrimaryColor, size: 22),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextField(
                          style: const TextStyle(color: kTextPrimaryColor, fontWeight: FontWeight.w600),
                          obscureText: true,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline_rounded, color: kPrimaryColor, size: 22),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32.0),
                        RoundedButton(
                          title: 'Log In',
                          onPressed: () {
                            Navigator.pushNamed(context, '/home');
                          },
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(color: kTextSecondaryColor, fontWeight: FontWeight.w500),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(context, '/registration'),
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
