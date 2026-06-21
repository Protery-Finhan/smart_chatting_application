import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'home_screen.dart';
import 'constants.dart';

void main() {
  runApp(const SmartChat());
}

class SmartChat extends StatelessWidget {
  const SmartChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Chat',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kPrimaryColor,
          primary: kPrimaryColor,
          secondary: kAccentColor,
          surface: kSurfaceColor,
          background: kBackgroundColor,
        ),
        textTheme: const TextTheme(
          displayLarge: kTitleTextStyle,
          bodyLarge: TextStyle(color: kTextPrimaryColor, fontSize: 16),
          bodyMedium: TextStyle(color: kTextSecondaryColor, fontSize: 14),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          iconTheme: IconThemeData(color: kTextPrimaryColor),
          titleTextStyle: TextStyle(
            color: kTextPrimaryColor,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/registration': (context) => const RegistrationScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
