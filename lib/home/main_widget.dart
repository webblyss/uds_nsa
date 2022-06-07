import 'package:cached_network_image/cached_network_image.dart';
import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsa_app/pages/bug/bug.dart';
import 'package:nsa_app/pages/report/issue.dart';
import 'package:nsa_app/pages/scrapping/headache.dart';
import 'package:nsa_app/screens/password.dart';
import 'package:nsa_app/screens/start_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuWidget extends StatefulWidget {
  final GlobalKey<SwipeDrawerState> drawerKey;

  const MenuWidget({
    Key key,
    this.drawerKey,
  }) : super(key: key);

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  final TextStyle colorStyle = TextStyle(color: Colors.white);
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Image image;
  String firstName;
  String lastName;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/icon/icon.png'),
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () async {
                  // await Share.text("UDS APP", "App", "");
                },
                leading: Icon(Icons.share),
                title: Text(
                  "Share app",
                  style: colorStyle,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                      CupertinoPageRoute(builder: (ctx) => FeedbackScreen()));
                },
                leading: Icon(Icons.feedback),
                title: Text(
                  "FeedBack",
                  style: colorStyle,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .push(CupertinoPageRoute(builder: (ctx) => ReportBug()));
                },
                leading: Icon(Icons.bug_report),
                title: Text(
                  "Report bug",
                  style: colorStyle,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .push(CupertinoPageRoute(builder: (ctx) => AboutApp()));
                },
                leading: Icon(Icons.info),
                title: Text(
                  "About App",
                  style: colorStyle,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                      CupertinoPageRoute(builder: (ctx) => ChangePassword()));
                },
                leading: Icon(Icons.lock),
                title: Text(
                  "Change password",
                  style: colorStyle,
                ),
              ),
              ListTile(
                onTap: () {
                  _prefs.then((value) {
                    value.remove('userLastName');
                  });
                  Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(builder: (ctx) => Login()),
                      (route) => false);
                },
                leading: Icon(Icons.exit_to_app),
                title: Text(
                  "Log out",
                  style: colorStyle,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
