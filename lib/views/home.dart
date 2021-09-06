import 'package:firebase_authentication/constants/app_colors.dart';
import 'package:firebase_authentication/constants/app_fonts.dart';
import 'package:firebase_authentication/local_storage/user_preference.dart';
import 'package:firebase_authentication/services/firebase_auth_services.dart';
import 'package:firebase_authentication/views/login.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? name;
  bool loading = false;
   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadUser();
  }

  _loadUser() async {
    dynamic user = await UserPreferences().getUserData();
    setState(() {
      name = user['name'];
      print('state $name');
    });
  }

  Future<void> _logout() async {
    await AuthServices().logout();
    Navigator.of(context).pushReplacementNamed(Login.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print('user $name');
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
        actions: [
        Padding(
          padding: EdgeInsets.only(top: size.width * 0.04, right: size.width * 0.04),
          child: TextButton(onPressed: _logout, child: Text('Logout', style: AppFonts.link)),
        )
      ],),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: loading? CircularProgressIndicator(
          color: Colors.black,               
        ) : Text('Hi $name', style: AppFonts.heading)
        ),
      ),
    );
  }
}
