import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class HospitalProfilePage extends StatefulWidget {
  var data;

  HospitalProfilePage({Key key, @required this.data}) : super(key: key);

  @override
  _HospitalProfilePageState createState() => _HospitalProfilePageState(data);
}

class _HospitalProfilePageState extends State<HospitalProfilePage> {
  AssetImage map1 = AssetImage("assets/map.jpg");
  String _bedType;
  num _bedCount;
  final firestoreInstance = FirebaseFirestore.instance;
  var data;

  _HospitalProfilePageState(this.data);

  Widget _buildPopupDialog(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return new AlertDialog(
        title: const Text('Request Bed'),
        content: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                DropdownButton<String>(
                  value: _bedType,
                  focusColor: Colors.white,
                  // elevation: 5,
                  style: TextStyle(color: Colors.white),
                  iconEnabledColor: Colors.black,
                  onChanged: (String value) {
                    _bedType = value;
                    setState(() {
                      _bedType = value;
                    });
                  },
                  hint: Text(
                    "Select Bed Type",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  items: <String>['Isolation', 'ICU', 'General', 'Delux']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              children: [
                Text("Number of Beds:"),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 70,
                  height: 55,
                  child: NumberInputWithIncrementDecrement(
                    controller: TextEditingController(),
                    onIncrement: (num value) {
                      _bedCount = value;
                    },
                    onDecrement: (num value) {
                      _bedCount = value;
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            RaisedButton(
              onPressed: () {
                firestoreInstance.collection("bed_requests").add({
                  "hid": "WXoBQ6WgZyuMgKZ5NFmU",
                  "num_of_beds": _bedCount,
                  "status": "Requested",
                  "user": user['username'],
                  "type": _bedType
                }).then((value) {
                  print(value.id);
                });
              },
              color: midColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0),
              ),
              child: Text(
                'Book',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Theme.of(context).primaryColor,
            child: const Text('Close'),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          // leading: IconButton(
          //   icon: const Icon(Icons.edit, color: Colors.black54),
          //   onPressed: () {},
          // ),
          title: new Text(
            'Hospital Details',
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
                Navigator.of(context).pushReplacementNamed('/search');
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            ClipPath(
              child: Container(color: darkColor.withOpacity(0.8)),
              clipper: getClipper(),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                            color: Colors.white60,
                            image: DecorationImage(
                                image: NetworkImage(USER_IMAGE),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(75.0)),
                            boxShadow: [
                              BoxShadow(blurRadius: 7.0, color: lightColor)
                            ])),
                    SizedBox(height: 20.0),
                    Text(
                      data["Hname"],
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                    SizedBox(height: 15.0),
                    Divider(color: Colors.black),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          padding: const EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: const BoxDecoration(
                              gradient: purpleGradient,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(80.0)),
                            ),
                            child: Container(
                              constraints: const BoxConstraints(
                                  minWidth: 88.0,
                                  minHeight:
                                      36.0), // min sizes for Material buttons
                              alignment: Alignment.center,
                              child: const Text(
                                'Chat',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialog(context));
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          padding: const EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: const BoxDecoration(
                              gradient: purpleGradient,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(80.0)),
                            ),
                            child: Container(
                              constraints: const BoxConstraints(
                                  minWidth: 88.0,
                                  minHeight:
                                      36.0), // min sizes for Material buttons
                              alignment: Alignment.center,
                              child: const Text(
                                'Book Bed',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Container(
                                padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                child: Material(
                                  color: Colors.white30,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Type:',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                                child: Material(
                                  color: Colors.white30,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        data['Type'] ?? "Private",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                                child: Material(
                                  color: Colors.white30,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Capacity:',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                                child: Material(
                                  color: Colors.white30,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        data['Total_Capacity'].toString() ??
                                            '50',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Divider(
                      color: Colors.black87,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Availability",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 90,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "ICU",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 6.0,
                              ),
                              CircularProgressIndicator(
                                strokeWidth: 5,
                                backgroundColor: lightColor,
                                valueColor:
                                    new AlwaysStoppedAnimation<Color>(midColor),
                                value:
                                    data['Available_ICU'] / data['Total_ICU'],
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                  '${(data['Available_ICU'] / data['Total_ICU'] * 100).round()}%'),
                              Text(
                                '${data['Available_ICU']} Beds',
                                style: TextStyle(fontSize: 10.0),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        SizedBox(
                          width: 90,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Non ICU",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 6.0,
                              ),
                              CircularProgressIndicator(
                                strokeWidth: 5,
                                backgroundColor: lightColor,
                                valueColor:
                                    new AlwaysStoppedAnimation<Color>(midColor),
                                value: data['Available_Non_ICU'] /
                                    data['Total_Non_ICU'],
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                  '${(data['Available_Non_ICU'] / data['Total_Non_ICU'] * 100).round()}%'),
                              Text(
                                '${data['Available_Non_ICU']} Beds',
                                style: TextStyle(fontSize: 10.0),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Divider(
                      color: Colors.black87,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                            child: Material(
                              color: Colors.white30,
                              child: GestureDetector(
                                onTap: () {},
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(Icons.phone)),
                              ),
                            )),
                        Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                            child: Material(
                              color: Colors.white30,
                              child: GestureDetector(
                                onTap: () {},
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    data['Contact'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                            child: Material(
                              color: Colors.white30,
                              child: GestureDetector(
                                onTap: () {},
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(Icons.email),
                                ),
                              ),
                            )),
                        Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                            child: Material(
                              color: Colors.white30,
                              child: GestureDetector(
                                onTap: () {},
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    data['Email'].toString() ?? '',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                            child: Material(
                              color: Colors.white30,
                              child: GestureDetector(
                                onTap: () {},
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(Icons.public),
                                ),
                              ),
                            )),
                        Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                            child: Material(
                              color: Colors.white30,
                              child: GestureDetector(
                                onTap: () {},
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    data['Website'] ?? '',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                            child: Material(
                              color: Colors.white30,
                              child: GestureDetector(
                                onTap: () {},
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(Icons.location_on)),
                              ),
                            )),
                        Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                            child: Material(
                              color: Colors.white30,
                              child: GestureDetector(
                                onTap: () {},
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    data['Address'] ?? '',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                        width: 600.0,
                        child: Image(
                          image: map1,
                          width: 550.0,
                          height: 300.0,
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ))
          ],
        )));
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
