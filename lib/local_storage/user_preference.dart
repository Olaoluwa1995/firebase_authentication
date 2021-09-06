import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveUserData(String email, String name) async {
    var commit = false;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("email", email);
    prefs.setString("name", name);
    commit = true;
    return commit;
  }

  Future<dynamic> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");
    String? name = prefs.getString("name");
    print(email);
    print(name);
    return {
      'email': email,
      'name': name,
    };
  }

  void removeUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("email");
    prefs.remove("name");
  }
}
