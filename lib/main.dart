import 'dart:io';

import 'package:firebase_authentication/config/size_config.dart';
import 'package:firebase_authentication/constants/widgets/error_widget.dart';
import 'package:firebase_authentication/constants/widgets/loader.dart';
import 'package:firebase_authentication/local_storage/user_preference.dart';

import 'package:firebase_authentication/services/firebase_auth_services.dart';
import 'package:firebase_authentication/views/home.dart';
import 'package:firebase_authentication/views/login.dart';
import 'package:firebase_authentication/views/register.dart';
import 'package:firebase_authentication/views/reset_password.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _init = Firebase.initializeApp();
    Future<dynamic> userData() => UserPreferences().getUserData();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
    return FutureBuilder(
      future: _init,
      builder: (context, snapshot) {
       if(snapshot.hasError) {
          return ErrorScreen();
        } else if (snapshot.hasData) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<AuthServices>.value(value: AuthServices()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: FutureBuilder(
                  future: Future.wait([userData()]),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                     if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        color: Colors.white,
                      );
                    }
                   else if (snapshot.data![0]['email'] != null && snapshot.data![0]['name'] != null) {
                      return Login();
                    } else {
                      return Register();
                    }
                  }),
              routes: {
                Login.routeName: (ctx) => Login(),
                Register.routeName: (ctx) => Register(),
                Home.routeName: (ctx) => Home(),
                ResetPassword.routeName: (ctx) => ResetPassword(),
              },
            ),
          );
        } else {
          Loader();
        }
        return Container();
        });
      });
    }); 
  }
}

