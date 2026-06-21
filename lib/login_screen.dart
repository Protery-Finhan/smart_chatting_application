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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: kPrimaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Hero(
                  tag: 'logo',
                  child: Icon(
                    Icons.chat_bubble_rounded,
                    size: 80,
                    color: kPrimaryColor,
                  ),
                ),
                const SizedBox(height: 48.0),
                TextField(
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    // Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Email',
                    hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  obscureText: true,
                  onChanged: (value) {
                    // Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 24.0),
                RoundedButton(
                  title: 'Log In',
                  color: kPrimaryColor,
                  onPressed: () {
                    // Directing to home page
                    Navigator.pushNamed(context, '/home');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
