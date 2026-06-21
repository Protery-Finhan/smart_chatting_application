import 'package:flutter/material.dart';
import 'constants.dart';
import 'components.dart';
import 'welcome_screen.dart'; // To reuse ModernBackgroundPainter

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: kTextPrimaryColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const Hero(
                              tag: 'logo',
                              child: Icon(
                                Icons.chat_bubble_rounded,
                                size: 70,
                                color: kPrimaryColor,
                              ),
                            ),
                            const SizedBox(height: 40.0),
                            const Text(
                              'Create Account',
                              textAlign: TextAlign.center,
                              style: kTitleTextStyle,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Join our community and start chatting today',
                              textAlign: TextAlign.center,
                              style: kSubTitleTextStyle,
                            ),
                            const SizedBox(height: 48.0),
                            TextField(
                              style: const TextStyle(color: kTextPrimaryColor, fontWeight: FontWeight.w600),
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {},
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Email',
                                prefixIcon: const Icon(Icons.email_outlined, color: kPrimaryColor),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            TextField(
                              style: const TextStyle(color: kTextPrimaryColor, fontWeight: FontWeight.w600),
                              obscureText: true,
                              onChanged: (value) {},
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Password',
                                prefixIcon: const Icon(Icons.lock_outline_rounded, color: kPrimaryColor),
                              ),
                            ),
                            const SizedBox(height: 32.0),
                            RoundedButton(
                              title: 'Sign Up',
                              onPressed: () {
                                Navigator.pushNamed(context, '/home');
                              },
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have an account? ",
                                  style: TextStyle(color: kTextSecondaryColor),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pushNamed(context, '/login'),
                                  child: const Text(
                                    'Log In',
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
