import 'package:firebase_authentication/config/size_config.dart';
import 'package:firebase_authentication/constants/app_colors.dart';
import 'package:firebase_authentication/constants/app_fonts.dart';
import 'package:firebase_authentication/constants/widgets/custom_button.dart';
import 'package:firebase_authentication/constants/widgets/custom_error_dialog.dart';
import 'package:firebase_authentication/constants/widgets/custom_input.dart';
import 'package:firebase_authentication/constants/widgets/loader.dart';
import 'package:firebase_authentication/services/firebase_auth_services.dart';
import 'package:firebase_authentication/views/home.dart';
import 'package:firebase_authentication/views/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  static const routeName = '/register';
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _registerFormKey = GlobalKey<FormState>();
  bool obsecurePassword = true;

  Map<String, dynamic> userData = {
    'name': '',
    'email': '',
    'password': '',
  };

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

  String? _nameValidator(value) {
    if (value.isEmpty) {
      return 'Please enter name';
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

  Future<void>? _register() {
    if (!_registerFormKey.currentState!.validate()) {
      // Invalid
      return null;
    }
    _registerFormKey.currentState!.save();
    _showloader();
    AuthServices().register(userData['email'], userData['password'], userData['name']).then((value) {
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
                    height: size.height * 0.05,
                  ),
              Center(
                child: Text(
                  'Register',
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
                  key: _registerFormKey,
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
                            hint: 'Dion',
                            label: 'Name',
                            onSaved: (value) {
                              userData['name'] = value!;
                            },
                            validator: _nameValidator,
                          ),
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
                        
                          CustomInput(
                            obsecure: obsecurePassword,
                            hint: '*********',
                            label: 'Password',
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
                         
                          SizedBox(
                            height: SizeConfig.heightMultiplier! * 5,
                          ),
                          CustomButton(
                              text: 'Register',
                              onpressed: _register,
                              width: size.width * 0.9),
                          SizedBox(
                            height: SizeConfig.heightMultiplier!,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Text('Already have an acount?', style: AppFonts.body1),
                            TextButton(onPressed: () => Navigator.of(context).pushReplacementNamed(Login.routeName), child: Text('Login', style: AppFonts.link)),
                          ],),
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