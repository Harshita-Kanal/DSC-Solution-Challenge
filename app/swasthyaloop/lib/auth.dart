// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:swasthyaloop/Screens/Login/components/body.dart';
import 'main.dart';

class AuthService {
  Future<bool> login(String username, String pass) async {
    CollectionReference patients =
        FirebaseFirestore.instance.collection('patients');
    QuerySnapshot docs = await patients
        .where('username', isEqualTo: username)
        .where('password', isEqualTo: password)
        .get();
    if (docs.docs.isEmpty) {
      print("Invalid Credentials");
      return false;
    } else {
      user = docs.docs[0].data();
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool("isLogged", true);
      pref.setString("username", user['username']);
      pref.setString("fname", user['fname']);
      pref.setString("lname", user['lname']);
      pref.setInt("age", user['age']);
      pref.setString("gender", user['gender']);

      return true;
    }
  }

  // Logout
  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('isLogged', false);
    pref.setString('username', '');
    pref.setString("fname", '');
    pref.setString("lname", '');
    pref.setInt("age", 0);
    pref.setString("gender", '');
    return;
  }
}
