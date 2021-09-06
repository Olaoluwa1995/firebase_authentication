import 'package:firebase_authentication/config/size_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _init = Firebase.initializeApp();
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
          return ErrorWidget();
        } else if (snapshot.hasData) {
          //return Login();
        } else {
          Loading();
        }
        return Container();
        });
      });
    });
  }
}

class ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Icon(Icons.error),
            Text('Oops! Something went wrong!')
          ],
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator()
      ),
    );
  }
}