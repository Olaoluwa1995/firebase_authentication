import 'package:firebase_authentication/config/size_config.dart';
import 'package:flutter/material.dart';

// App Fonts Class - Resource class for storing app level font constants
class AppFonts {
  static TextStyle valueStyle = TextStyle(
    fontSize: SizeConfig.textMultiplier! * 2.3,
    color: Colors.black,
    fontWeight: FontWeight.w700,
  );

  static TextStyle body1 = TextStyle(
    fontSize: SizeConfig.textMultiplier! * 1.6,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static TextStyle body2 = TextStyle(
    fontSize: SizeConfig.textMultiplier! * 1.3,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
}