import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/models/user.dart';
import 'package:firebase_authentication/services/database_service.dart';
import 'package:flutter/material.dart';

class AuthServices with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void setLoading (val) {
    _isLoading = val;
    notifyListeners();
  }

  void setMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }

  AppUser? _userFromFirebaseUser(User? user) {
    // ignore: unnecessary_null_comparison
    return user != null ? AppUser(user.uid) : null;
  }

  Stream<AppUser?> get user {
    return firebaseAuth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future register (String email, String password, String name) async {
    setLoading(true);
    try {
      UserCredential authResult = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = authResult.user;
      print(user);
      
      await DatabaseService(uid: user!.uid).updateUserData(name);
      setLoading(false);
      return _userFromFirebaseUser(user);
    } on SocketException {
      setLoading(false);
      setMessage('No internet, please connect to internet');
    } catch (e) {
      setLoading(false);
      setMessage(e);
    }
    notifyListeners();
  }

  Future login (String email, String password) async {
    setLoading(true);
    try {
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user = authResult.user;
      setLoading(false);
      return user;
    } on SocketException {
      setLoading(false);
      setMessage('No internet, please connect to internet');
    } catch (e) {
      // print(e.toString());
      setLoading(false);
      setMessage(e.toString());
    }
    notifyListeners();
  }

  Future logout() async {
    await firebaseAuth.signOut();
  }
}