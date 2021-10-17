import 'package:flutter/material.dart';
import 'package:swasthyaloop/hospital_profile.dart';
import 'package:swasthyaloop/utils.dart';
import 'package:swasthyaloop/widgets/moods.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'main.dart';
import 'utils.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Widget> hospitalList = [];
  final firestoreInstance = FirebaseFirestore.instance;
  int _selectedIndex = 1;
  AssetImage map = AssetImage("assets/map.jpg");
  String _bedType;
  num _bedCount;
  bool isLoading = false;

  @override
  void initState() {
    _getHospitals();
    super.initState();
  }

  void onTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
    if (_selectedIndex == 1) {
      Navigator.of(context).pushReplacementNamed('/search');
    } else if (_selectedIndex == 0) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      Navigator.of(context).pushReplacementNamed('/chat');
    }
  }

  _getHospitals() {
    List<Widget> currentList = [
      _image(),
      _areaSpecialistsText(),
    ];

    firestoreInstance.collection("hospitals").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        currentList.add(_specialistsCardInfo(result.data()));
      });
      setState(() {
        isLoading = false;
        hospitalList = currentList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.person, //logo will go here
              color: lightColor,
            ),
            onPressed: () {
              // Go to profile page
              Navigator.of(context).pushReplacementNamed('/profile');
            },
          ),
          title: Row(
            children: [
              SizedBox(
                width: 28.0,
              ),
              Image.asset(
                'assets/icons/logo_red_small.png',
                fit: BoxFit.contain,
                height: 48,
              ),
              Container(
                padding: const EdgeInsets.all(0.0),
                child: Text(
                  'SwasthyaLoop',
                  style: TextStyle(color: lightColor),
                ),
              )
            ],
          ),
        ),
        backgroundColor: mainBgColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.topCenter,
                overflow: Overflow.visible,
                children: <Widget>[
                  _backBgCover(),
                  _greetings(),
                  // _moodsHolder(),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: hospitalList,
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  LineAwesomeIcons.home,
                  size: 30.0,
                ),
                title: Text('1')),
            BottomNavigationBarItem(
                icon: Icon(
                  LineAwesomeIcons.search,
                  size: 30.0,
                ),
                title: Text('2')),
            BottomNavigationBarItem(
                icon: Icon(
                  LineAwesomeIcons.gratipay,
                  size: 30.0,
                ),
                title: Text('3')),
          ],
          onTap: onTapped,
        ),
      );
    });
  }

  Container _backBgCover() {
    return Container(
      height: 260.0,
      decoration: BoxDecoration(
        gradient: purpleGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
    );
  }

  Widget _specialistsCardInfo(var hospitalData) {
    if (hospitalData == {}) {
      return Container();
    }
    var data = hospitalData;
    data['Total_ICU'] = data['Total_ICU'] ?? '50';
    data['Total_Non_ICU'] = data['Total_Non_ICU'] ?? '100';
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
      margin: EdgeInsets.only(
        bottom: 20.0,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1.0,
              blurRadius: 6.0,
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Color(0xFFD9D9D9),
                backgroundImage: NetworkImage(USER_IMAGE),
                radius: 36.0,
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 150,
                    child: RichText(
                      overflow: TextOverflow.clip,
                      text: TextSpan(
                        text: data['Type'] + ' Hospital\n',
                        style: TextStyle(
                          color: Colors.purple,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 1.3,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: data['Hname'] + '\n',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: '\nAvailability:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Row(
                    children: [
                      SizedBox(
                        width: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("ICU"),
                            SizedBox(
                              height: 6.0,
                            ),
                            CircularProgressIndicator(
                              strokeWidth: 5,
                              backgroundColor: lightColor,
                              valueColor:
                                  new AlwaysStoppedAnimation<Color>(midColor),
                              value: data['Available_ICU'] / data['Total_ICU'],
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              '${(data['Available_ICU'] / data['Total_ICU'] * 100).round()}%',
                            ),
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
                            Text("Non ICU"),
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
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      RaisedButton(
                        onPressed: () => {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  HospitalProfilePage(data: data),
                            ),
                          )
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
                              'View Details',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
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
                  )
                ],
              ),
            ],
          ),
          Icon(
            LineAwesomeIcons.heart,
            color: lightColor,
            size: 36,
          ),
        ],
      ),
    );
  }

  Widget _areaSpecialistsText() {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Hospitals In Your Area',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          FlatButton(
              onPressed: () {
                setState(() {
                  isLoading = false;
                });
              },
              child: Text(
                'See All',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: midColor,
                ),
              ))
        ],
      ),
    );
  }

  Positioned _greetings() {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 20.0)),
          SizedBox(height: 50.0),
          Row(
            children: [
              Padding(padding: EdgeInsets.only(top: 30.0)),
              Text(
                'Search',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 150,
              ),
              IconButton(
                  icon: Icon(Icons.map), color: Colors.white, onPressed: () {}),
              IconButton(
                icon: Icon(Icons.sort),
                onPressed: () {},
                color: Colors.white,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 350.0,
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(),
                      hintText: 'Search'),
                ),
                // Padding(padding: EdgeInsets.only(bottom:10.0)),
                // TextField(
                //   decoration: InputDecoration(
                //     filled: true,
                //     fillColor: Colors.white,
                //     icon: Icon(Icons.location_on,color: Colors.white,),
                //     border: OutlineInputBorder(),
                //     hintText: 'Location'
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 350.0,
            height: 60.0,
            child: TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(),
                  hintText: 'Location'),
            ),
          )
        ],
      ),
    );
  }

  Widget _image() {
    return Container(
        width: 600.0,
        child: Image(
          image: map,
          width: 550.0,
          height: 300.0,
        ));
  }

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
}
