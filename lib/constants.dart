import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF6C63FF);
const kSecondaryColor = Color(0xFF03DAC5);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
  contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(16.0)),
    borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(16.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor, width: 3.0),
    borderRadius: BorderRadius.all(Radius.circular(16.0)),
  ),
  filled: true,
  fillColor: Colors.white,
);

const kTitleTextStyle = TextStyle(
  fontSize: 40.0,
  fontWeight: FontWeight.w800,
  color: Color(0xFF2D2D2D),
  letterSpacing: -0.5,
);

const kButtonTextStyle = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);
