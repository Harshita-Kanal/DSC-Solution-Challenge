import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'auth.dart';
import 'utils.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.edit, color: Colors.black54),
            onPressed: () {},
          ),
          title: new Text(
            'Edit Profile',
            style: new TextStyle(
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: new Icon(
                Icons.close,
                color: Colors.black,
                size: 30,
              ),
              tooltip: 'close',
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/home');
              },
            ),
          ],
        ),
        body: new Stack(
          children: <Widget>[
            ClipPath(
              child: Container(color: darkColor.withOpacity(0.8)),
              clipper: getClipper(),
            ),
            Positioned(
                width: MediaQuery.of(context).size.width,
                top: MediaQuery.of(context).size.height / 15,
                child: Column(
                  children: <Widget>[
                    Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://cdn.pixabay.com/photo/2017/02/20/18/14/kawaii-2083521_960_720.png'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.all(Radius.circular(75.0)),
                            boxShadow: [
                              BoxShadow(blurRadius: 7.0, color: lightColor)
                            ])),
                    SizedBox(height: 20.0),
                    Text(
                      user['fname'] + ' ' + user['lname'],
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                    SizedBox(height: 15.0),
                    Divider(color: Colors.black),
                    Container(
                        padding: EdgeInsets.fromLTRB(20, 25, 0, 0),
                        child: Material(
                          color: Colors.white30,
                          child: GestureDetector(
                            onTap: () {},
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Payment Options',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),
                    // SizedBox(height: 15.0),
                    Container(
                        padding: EdgeInsets.fromLTRB(20, 25, 0, 0),
                        child: Material(
                          color: Colors.white30,
                          child: GestureDetector(
                            onTap: () {},
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Transaction History',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 15.0),
                    Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                        child: Material(
                          color: Colors.white30,
                          child: GestureDetector(
                            onTap: () {},
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Status History',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 15.0),
                    Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                        child: Material(
                          color: Colors.white30,
                          child: GestureDetector(
                            onTap: () {},
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Buy Coins',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 15.0),
                    Divider(
                      color: Colors.black87,
                    ),
                    SizedBox(height: 15.0),
                    Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Material(
                          color: Colors.white30,
                          child: GestureDetector(
                            onTap: () {},
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Help',
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 20.0,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 15.0),
                    Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Material(
                          color: Colors.white30,
                          child: GestureDetector(
                            onTap: () {},
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'About',
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 20.0,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 15.0),
                    Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Material(
                          color: Colors.white30,
                          child: GestureDetector(
                            onTap: () {
                              AuthService appAuth = new AuthService();
                              appAuth.logout().then((_) => Navigator.of(context)
                                  .pushReplacementNamed('/login'));
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Log out',
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 20.0,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        ))
                  ],
                ))
          ],
        ));
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 3);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
