import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:nsa_app/screens/password.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDetails extends StatefulWidget {
  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  void initState() {
    super.initState();

    getData();
    getImage();
  }

  

  String firstName;
  String lastName;
  String indexNumber;
  getData() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((value) {
      setState(() {
        firstName = value.getString("userFirstName");
        lastName = value.getString("userLastName");
        indexNumber = value.getString("indexNumber");
      });
    });
  }

  String image;
  String id;
  String firebaseID;
  SharedPreferences loginData;
  TextEditingController controller = TextEditingController();
getImage() async {
 await FirebaseFirestore.instance.collection("student_login").get().then((value) {
      value.docs.forEach((element) {
        if (element.get("ID") == indexNumber) {
          setState(() {
            image = element.get('Image');
          });
        }
      });
    });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        // centerTitle: true,
        actions: <Widget>[
          Image.asset("assets/images/uds.png", height: 50, width: 50)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: CachedNetworkImageProvider(image),
            ),
            SizedBox(
              height: 30,
            ),
            Card(
              child: ListTile(
                onTap: () {},
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Name"),
                    Text("$firstName $lastName",
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
                leading: Icon(Icons.person),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Index Number"),
                    Text("$indexNumber", style: TextStyle(color: Colors.grey)),
                  ],
                ),
                leading: Icon(Icons.school),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Department"),
                    Text("Nursing Department",
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
                leading: Icon(Icons.departure_board),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (ctx) => ChangePassword(),
                    ),
                  );
                },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Security"),
                    Text(
                      "Change Password",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                leading: Icon(Icons.lock),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
