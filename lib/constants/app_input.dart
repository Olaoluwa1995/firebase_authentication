import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppInput {
  static const focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(30),
    ),
    borderSide: BorderSide(
      color: AppColors.primaryColor,
    ),
  );

  static const border = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(30),
    ),
    borderSide: BorderSide.none,
  );

  static const errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(30),
    ),
    borderSide: BorderSide(
      color: Colors.transparent,
    ),
  );

  static const TextStyle errorStyle = TextStyle(
      fontFamily: 'Ubuntu', fontSize: 14, backgroundColor: Colors.transparent
      //fontWeight: FontWeight.bold,
      );
}
