import 'package:flutter/material.dart';

// Modern Color Palette
const kPrimaryColor = Color(0xFF6366F1); // Indigo
const kPrimaryLightColor = Color(0xFFEEF2FF);
const kAccentColor = Color(0xFFF43F5E); // Rose
const kBackgroundColor = Color(0xFFF8FAFC);
const kSurfaceColor = Colors.white;
const kTextPrimaryColor = Color(0xFF1E293B);
const kTextSecondaryColor = Color(0xFF64748B);
const kSuccessColor = Color(0xFF10B981);
const kWarningColor = Color(0xFFF59E0B);

// Modern Gradients
const kPrimaryGradient = LinearGradient(
  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const kAccentGradient = LinearGradient(
  colors: [Color(0xFFF43F5E), Color(0xFFFB7185)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

// Modern Text Styles
const kTitleTextStyle = TextStyle(
  fontSize: 32.0,
  fontWeight: FontWeight.w900,
  color: kTextPrimaryColor,
  letterSpacing: -1.0,
  fontFamily: 'PlusJakartaSans', // Assuming a modern font or fallback to sans-serif
);

const kHeadlineTextStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.w800,
  color: kTextPrimaryColor,
  letterSpacing: -0.5,
);

const kSubTitleTextStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
  color: kTextSecondaryColor,
  letterSpacing: 0.2,
  height: 1.5,
);

const kBodyTextStyle = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.w400,
  color: kTextPrimaryColor,
  height: 1.4,
);

const kButtonTextStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w700,
  color: Colors.white,
  letterSpacing: 0.5,
);

// Modern Decorations
final kModernShadow = [
  BoxShadow(
    color: kPrimaryColor.withValues(alpha: 0.12),
    blurRadius: 24,
    offset: const Offset(0, 8),
  ),
];

final kSoftShadow = [
  BoxShadow(
    color: Colors.black.withValues(alpha: 0.04),
    blurRadius: 16,
    offset: const Offset(0, 4),
  ),
];

const kTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(color: kTextSecondaryColor, fontWeight: FontWeight.w400),
  contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 24.0),
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

// Layout Constants
const double kDefaultPadding = 24.0;
const double kDefaultRadius = 24.0;
