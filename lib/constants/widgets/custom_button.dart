import 'package:firebase_authentication/config/size_config.dart';
import 'package:firebase_authentication/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onpressed;
  final double width;
  final Color? color;

  const CustomButton(
      {Key? key,
      required this.text,
      required this.onpressed,
      required this.width,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: color != null ? color : AppColors.primaryColor,
      ),
      child: MaterialButton(
        elevation: 0,
        height: SizeConfig.heightMultiplier! * 5,
        minWidth: width,
        splashColor: Colors.white10,
        shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30)),
        onPressed: onpressed,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Ubuntu',
            fontSize: SizeConfig.textMultiplier! * 2,
            color: Colors.white,
          ),
        ),
        color: Colors.transparent,
      ),
    );
  }
}
