import 'package:flutter/material.dart';
import 'package:swasthyaloop/Screens/Login/login_screen.dart';
import 'package:swasthyaloop/Screens/Welcome/welcome_screen.dart';
import 'package:swasthyaloop/constants.dart';
import 'package:swasthyaloop/hospital_profile.dart';
import 'Homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'search.dart';
import 'chat.dart';
import 'auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'profile.dart';

Widget defaultHome;
String username = '';
var user = {};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool isLogged = pref.getBool('isLogged') ?? false;
  username = pref.getString('username') ?? '';

  defaultHome = new WelcomeScreen();
  if (isLogged) {
    defaultHome = new Homepage();
    user = {
      'fname': pref.getString('fname'),
      'lname': pref.getString('lname'),
      'username': pref.getString('username'),
      'gender': pref.getString('gender'),
      'age': pref.getInt('age')
    };
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Swastyaloop',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: defaultHome,
        routes: <String, WidgetBuilder>{
          "/home": (BuildContext context) => Homepage(),
          "/login": (BuildContext context) => LoginScreen(),
          "/search": (BuildContext context) => SearchPage(),
          "/chat": (BuildContext context) => ChatPage(),
          "/profile": (BuildContext context) => ProfilePage(),
          "/hprofile": (BuildContext context) => HospitalProfilePage(data: {}),
        });
  }
}
