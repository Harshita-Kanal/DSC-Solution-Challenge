import 'package:flutter/material.dart';
import 'package:swasthyaloop/Screens/Login/components/background.dart';
import 'package:swasthyaloop/Screens/Signup/signup_screen.dart';
import 'package:swasthyaloop/components/already_have_an_account_acheck.dart';
import 'package:swasthyaloop/components/rounded_button.dart';
import 'package:swasthyaloop/components/rounded_input_field.dart';
import 'package:swasthyaloop/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swasthyaloop/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

String username = '';
String password = '';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Username",
              onChanged: (value) {
                username = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: () async {
                AuthService auth = new AuthService();
                if (await auth.login(username, password)) {
                  Navigator.of(context).pushReplacementNamed('/home');
                } else {
                  Fluttertoast.showToast(
                      msg: "Invalid Credentials",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
