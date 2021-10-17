import 'package:flutter/material.dart';
import 'package:swasthyaloop/utils.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'models/chat_models.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int _selectedIndex = 2;

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

  @override
  Widget build(BuildContext context) {
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
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _chats(),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
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
  }

  Container _backBgCover() {
    return Container(
      height: 160.0,
      decoration: BoxDecoration(
        gradient: purpleGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
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
                'Chat',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 150,
              ),
            ],
          ),
          // SizedBox(
          //   height: 10,
          // ),
        ],
      ),
    );
  }

  Widget _chats() {
    return Container(
      height: 75.0 * (messageData.length + 1),
      child: ListView.builder(
        // confirm with Dhruv
        physics: const NeverScrollableScrollPhysics(),
        itemCount: messageData.length,
        itemBuilder: (context, i) => Column(
          children: <Widget>[
            Divider(
              height: 10.0,
            ),
            ListTile(
                leading: CircleAvatar(
                    maxRadius: 25,
                    backgroundImage: NetworkImage(messageData[i].imageUrl),
                    backgroundColor: Colors.pink.shade50),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(messageData[i].name,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(messageData[i].time,
                        style: TextStyle(color: Colors.grey, fontSize: 16.0))
                  ],
                ),
                subtitle: Container(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(messageData[i].message,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0,
                      )),
                ),
                onTap: () {})
          ],
        ),
      ),
    );
    // ListView.builder(
    //   itemCount: messageData.length,
    //   itemBuilder: (context, i) =>
    //   Column(
    //     children: <Widget>[
    //       Divider(
    //         height: 20.0,
    //       ),
    //       ListTile(
    //         leading: CircleAvatar(
    //           maxRadius: 25,
    //           backgroundImage: NetworkImage(messageData[i].imageUrl),
    //         ),
    //         title: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: <Widget>[
    //             Text(messageData[i].name,
    //             style: TextStyle(fontWeight: FontWeight.bold)
    //             ),
    //             Text(messageData[i].time,
    //             style: TextStyle(
    //               color: Colors.grey,
    //               fontSize: 16.0
    //             )
    //             )
    //           ],
    //         ),
    //         subtitle: Container(
    //           padding: EdgeInsets.only(top: 5.0),
    //           child: Text(
    //             messageData[i].message,
    //             style: TextStyle(
    //               color: Colors.grey,
    //               fontSize: 15.0,
    //             )
    //           ),
    //         ),
    //         onTap: () {}
    //       )
    //     ],
    //   ),
    // );
  }
}
