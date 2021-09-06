import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/local_storage/user_preference.dart';
import 'package:flutter/material.dart';

class AuthServices with ChangeNotifier {
  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void setMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future register (String email, String password, String name) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      UserPreferences().saveUserData(email, name);
      return true;   
    } on SocketException {
      setMessage('No internet, please connect to internet');
    } catch (e) {
      return false;
    }
    notifyListeners();
  }

  Future login (String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      final userData = await UserPreferences().getUserData();
      print(userData);
      return true;   
    } on SocketException {
      setMessage('No internet, please connect to internet');
    } catch (e) {
      setMessage(e.toString());
      return false;
    }
    notifyListeners();
  }

  Future sendPasswordResetEmail (String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return true;   
    } on SocketException {
      setMessage('No internet, please connect to internet');
    } catch (e) {
      setMessage(e.toString());
      return false;
    }
    notifyListeners();
  }

  Future confirmPasswordReset (String code, String newPassword) async {
    try {
      firebaseAuth.confirmPasswordReset(code: code, newPassword: newPassword);
      return true;   
    } on SocketException {
      setMessage('No internet, please connect to internet');
    } catch (e) {
      setMessage(e.toString());
      return false;
    }
    notifyListeners();
  }

  Future logout() async {
    await firebaseAuth.signOut();
  }
}