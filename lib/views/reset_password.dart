import 'package:firebase_authentication/config/size_config.dart';
import 'package:firebase_authentication/constants/app_colors.dart';
import 'package:firebase_authentication/constants/app_fonts.dart';
import 'package:firebase_authentication/constants/widgets/custom_button.dart';
import 'package:firebase_authentication/constants/widgets/custom_error_dialog.dart';
import 'package:firebase_authentication/constants/widgets/custom_input.dart';
import 'package:firebase_authentication/constants/widgets/loader.dart';
import 'package:firebase_authentication/services/firebase_auth_services.dart';
import 'package:firebase_authentication/views/home.dart';
import 'package:firebase_authentication/views/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  static const routeName = '/reset-password';
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _resetPasswordKey = GlobalKey<FormState>();
  bool showNewPasswordInput = false;
  bool obsecurePassword = true;

  Map<String, dynamic> userData = {
    'email': '',
    'password': '',
    'code': '',
  };

  String? _codeValidator (value) {
    if (value.isEmpty) {
      return 'Please enter code';
    }
    return null;
  }

  String? _emailValidator(value) {
    if (value.isEmpty) {
      return 'Please enter email';
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Invalid Email';
    }
    return null;
  }

  String? _passwordValidator(value) {
    if (value.isEmpty) {
      return 'Please enter password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8';
    }
    return null;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => GestureDetector(
        child: ErrorView(message),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showloader() {
    showDialog(
      context: context,
      builder: (ctx) => Loader(),
    );
  }

  Future<void>? _sendPasswordResetEmail() {
    if (!_resetPasswordKey.currentState!.validate()) {
      return null;
    }
     _resetPasswordKey.currentState!.save();
    AuthServices().sendPasswordResetEmail(userData['email']).then((value) {
    if(value) {
      setState(() {
        showNewPasswordInput = true;
        final snackBar = SnackBar(
          elevation: 2,
          content: Text('Your reset code has been sent to your email. Copy the code and enter it below to create your new password!',
              style: TextStyle(
                  fontFamily: "Ubuntu",
                  fontWeight: FontWeight.w700,
                  fontSize: SizeConfig.textMultiplier! * 2,
                  color: Colors.white),
              textAlign: TextAlign.center),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.black54,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    } else {
        Navigator.pop(context);
        _showErrorDialog('Something went wrong. Please try again!');
    }
    });
    return null;

  }

  Future<void>? _resetPassword () {
    if (!_resetPasswordKey.currentState!.validate()) {
      return null;
    }
     _resetPasswordKey.currentState!.save();
    _showloader();
    AuthServices().confirmPasswordReset(userData['code'], userData['password']).then((value) {
    if(value) {
      Navigator.pop(context, true);
      Navigator.of(context).pushReplacementNamed(Home.routeName);
    } else {
        Navigator.pop(context);
        _showErrorDialog('Something went wrong. Please try again!');
    }
    });
    return null;

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/shape.png',
                  fit: BoxFit.cover, width: size.width * 0.4),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
              Center(
                child: Text(
                  'Reset Password',
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.textMultiplier! * 3,
                      fontFamily: 'Ubuntu'),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier! * 8,
              ),
              SizedBox(
                height: size.height * 0.8,
                child: Form(
                  key: _resetPasswordKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier! * 4),
                      child: Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.heightMultiplier! * 3,
                          ),
                          CustomInput(
                            hint: 'celine@gmail.com',
                            label: 'Email',
                            validator: _emailValidator,
                            onSaved: (value) {
                              userData['email'] = value!;
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.textMultiplier! * 3,
                          ),
                        if(showNewPasswordInput)
                          Column(
                            children: [
                               CustomInput(
                                label: 'Code',
                                onSaved: (value) {
                                  userData['code'] = value!;
                                },
                                validator: _codeValidator,
                              ),

                         
                              SizedBox(
                                height: SizeConfig.textMultiplier! * 3,
                              ),
                              CustomInput(
                                obsecure: obsecurePassword,
                                hint: '*********',
                                label: 'New Password',
                                onSaved: (value) {
                                  userData['password'] = value!;
                                },
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    obsecurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: AppColors.primaryColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      obsecurePassword = !obsecurePassword;
                                    });
                                  },
                                ),
                                validator: _passwordValidator,
                              ),
                            ],
                          ),
                         
                          SizedBox(
                            height: SizeConfig.heightMultiplier! * 5,
                          ),
                          CustomButton(
                              text: showNewPasswordInput ? 'Reset Password' : 'Get Reset Code',
                              onpressed: showNewPasswordInput ? _resetPassword : _sendPasswordResetEmail,
                              width: size.width * 0.9),
                               SizedBox(
                            height: SizeConfig.heightMultiplier!,
                          ),
                         
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}