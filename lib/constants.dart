import 'package:flutter/material.dart';

// Modern Color Palette
const kPrimaryColor = Color(0xFF6366F1); // Indigo
const kPrimaryLightColor = Color(0xFFEEF2FF);
const kAccentColor = Color(0xFFF43F5E); // Rose
const kBackgroundColor = Color(0xFFF8FAFC);
const kSurfaceColor = Colors.white;
const kTextPrimaryColor = Color(0xFF1E293B);
const kTextSecondaryColor = Color(0xFF64748B);

// Modern Gradients
const kPrimaryGradient = LinearGradient(
  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

// Modern Text Styles
const kTitleTextStyle = TextStyle(
  fontSize: 32.0,
  fontWeight: FontWeight.w800,
  color: kTextPrimaryColor,
  letterSpacing: -1.0,
);

const kSubTitleTextStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
  color: kTextSecondaryColor,
  letterSpacing: 0.2,
);

const kButtonTextStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
  color: Colors.white,
  letterSpacing: 0.5,
);

// Modern Decorations
final kModernShadow = [
  BoxShadow(
    color: kPrimaryColor.withOpacity(0.1),
    blurRadius: 20,
    offset: const Offset(0, 10),
  ),
];

const kTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(color: kTextSecondaryColor, fontWeight: FontWeight.w400),
  contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    borderSide: BorderSide.none,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
  filled: true,
  fillColor: Colors.white,
);
