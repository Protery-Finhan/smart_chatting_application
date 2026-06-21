import 'package:flutter/material.dart';
import 'constants.dart';
import 'components.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: const Icon(
                      Icons.chat_bubble_rounded,
                      size: 100,
                      color: kPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Smart Chat',
                    textAlign: TextAlign.center,
                    style: kTitleTextStyle,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Connect with the world instantly and securely.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 48.0),
                  RoundedButton(
                    title: 'Sign In',
                    color: kPrimaryColor,
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                  const SizedBox(height: 12),
                  OutlinedRoundedButton(
                    title: 'Create Account',
                    onPressed: () {
                      Navigator.pushNamed(context, '/registration');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
