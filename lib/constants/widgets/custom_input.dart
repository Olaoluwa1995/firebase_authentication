import 'package:firebase_authentication/constants/app_colors.dart';
import 'package:firebase_authentication/constants/app_fonts.dart';
import 'package:firebase_authentication/constants/app_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatelessWidget {
  final String? hint;
  final String? label;
  final String? description;
  final String? type;
  final double? width;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? initialValue;
  final bool obsecure;
  final bool enabled;
  final void Function(String?)? onSaved;
  final dynamic validator;
  final int maxLines;

  const CustomInput({
    Key? key,
    this.hint,
    this.label,
    this.initialValue = '',
    this.description,
    this.obsecure = false,
    required this.onSaved,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.type,
    this.width,
    this.enabled = true,
    this.maxLines = 1,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // ignore: prefer_if_null_operators
      width: width == null ? MediaQuery.of(context).size.width : width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
            child: TextFormField(
              cursorColor: AppColors.primaryColor,
              obscureText: obsecure,
              enabled: enabled,
              inputFormatters: [
                if (type == 'number') FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: type == 'number'
                  // ignore: prefer_const_constructors
                  ? TextInputType.numberWithOptions(signed: true, decimal: true)
                  : TextInputType.name,
              maxLength: type == 'number' ? 15 : 255,
              maxLines: maxLines,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(20),
                errorMaxLines: 1,
                hintText: hint,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                hintStyle: const TextStyle(
                    color: Colors.black26, fontFamily: 'Ubuntu', fontSize: 12),
                errorBorder: AppInput.errorBorder,
                errorStyle: AppInput.errorStyle,
                counterText: '',
                labelText: label,
                labelStyle: AppFonts.body1,
                focusedErrorBorder: AppInput.focusedBorder,
                filled: true,
                fillColor: enabled == true
                    ? Colors.grey.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.06),
                focusedBorder: AppInput.focusedBorder,
                border: AppInput.border,
              ),
              initialValue: initialValue,
              validator: validator,
              onSaved: onSaved,
            ),
          ),
          if (description != null)
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                description!,
                style: AppFonts.body2,
              ),
            ),
        ],
      ),
    );
  }
}