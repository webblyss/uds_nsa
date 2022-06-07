import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nsa_app/admin/login/login.dart';
import 'package:nsa_app/enum/color_constant.dart';
import 'package:nsa_app/enum/operation_model.dart';
import 'package:nsa_app/pages/bmi/screens/input_page.dart';
import 'package:nsa_app/pages/component/nursing.dart';
import 'package:nsa_app/pages/covid/covid.dart';
import 'package:nsa_app/pages/library/views/home.dart';
import 'package:nsa_app/pages/mmedical/layout.dart';
import 'package:nsa_app/pages/note/screens/note_list.dart';
import 'package:nsa_app/pages/nsa/nsa.dart';
import 'package:nsa_app/pages/portal/portal.dart';
import 'package:nsa_app/screens/favourite.dart';
import 'package:nsa_app/screens/profile.dart';
import 'package:nsa_app/screens/suggest.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowCase extends StatefulWidget {
  final GlobalKey<SwipeDrawerState> drawerKey;

  const ShowCase({
    Key key,
    this.drawerKey,
  }) : super(key: key);

  @override
  _ShowCaseState createState() => _ShowCaseState();
}

class _ShowCaseState extends State<ShowCase>
    with SingleTickerProviderStateMixin {
  String url = "https://ucm.uds.edu.gh/";
  String facebook =
      "https://web.facebook.com/Nursing-Students-Association-NSA-UDS-360613407854446";
  String name1 = "Student Portal";

  String name2 = "UDS-NSA-Facebook-Page";
  var green = Color(0xFF4caf6a);
  var greenLight = Color(0xFFd8ebde);

  var red = Color(0xFFf36169);
  var redLight = Color(0xFFf2dcdf);

  var blue = Color(0xFF398bcf);
  var blueLight = Color(0xFFc1dbee);



  Image imageFile;
  @override
  void initState() {
    super.initState();

    getData();
    getImage();
  }

  String firstName;
  String lastName;
  String indexNumber;
  String imageUrl;
  String sharePreferenceImage;
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

  getImage() {
    FirebaseFirestore.instance.collection("student_login").get().then((value) {
      value.docs.forEach((element) {
        if (element.get("ID") == indexNumber) {
          setState(() {
            imageUrl = element.get('Image');
          });
          Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
          _prefs.then((value) {
            setState(() {
              value.setString("prefImage", element.get('Image'));
              sharePreferenceImage = value.getString("prefImage");
            });
          });
        }
      });
    });
  }

  // Current selected
  int current = 0;

  // Handle Indicator
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 8),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          // Custom AppBar
          AppBar(
            backgroundColor: Colors.white,
            title: Text('Dash Board'),
            leading: InkWell(
              onTap: () {
                if (widget.drawerKey.currentState.isOpened()) {
                  widget.drawerKey.currentState.closeDrawer();
                } else {
                  widget.drawerKey.currentState.openDrawer();
                }
              },
              child: Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.heart,
                  color: Colors.red,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(CupertinoPageRoute(builder: (ctx) => Favourite()));
                },
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (ctx) => ProfileDetails()));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10000.0),
                                  child: CircleAvatar(
              radius: 20,
              backgroundImage: CachedNetworkImageProvider(imageUrl),
            ),
                ),
              )
            ],
          ),
          // Card Section
          SizedBox(
            height: 25,
          ),

          GestureDetector(
            onLongPress: () {
              Navigator.push(
                  context, CupertinoPageRoute(builder: (ctx) => LoginPage()));
            },
            child: Padding(
              padding: EdgeInsets.only(left: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        'Hello ',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: kBlackColor,
                        ),
                      ),
                      
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '$lastName',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: kBlackColor,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: FittedBox(
                fit: BoxFit.fill,
                alignment: Alignment.topCenter,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(CupertinoPageRoute(builder: (ctx) => Info()));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                        ),
                        child: Container(
                          height: 150,
                          width: 200.0,
                          color: redLight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.school,
                                color: red,
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                ' UDS NSA',
                                style: TextStyle(
                                    color: red, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (ctx) => StudentPortal(
                                  url: url,
                                  name: name1,
                                )));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                        ),
                        child: Container(
                          height: 150.0,
                          width: 200.0,
                          color: blueLight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.contact_phone,
                                color: blue,
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                'Student Portal',
                                style: TextStyle(
                                    color: blue, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                      child: Container(
                        height: 150.0,
                        width: 200.0,
                        color: greenLight,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => SuggestionBox(),
                              ),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.mail_outline,
                                color: green,
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                'NSA Complain Box',
                                style: TextStyle(
                                    color: green, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                      child: Container(
                        height: 150.0,
                        width: 200.0,
                        color: redLight,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => Home(),
                              ),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.mail_outline,
                                color: red,
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                'Modern Library',
                                style: TextStyle(
                                    color: red, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Operation Section
          Padding(
            padding: EdgeInsets.only(left: 16, bottom: 13, top: 29, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Menu',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: kBlackColor,
                  ),
                ),
                Row(
                  children: map<Widget>(
                    datas,
                    (index, selected) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        height: 9,
                        width: 9,
                        margin: EdgeInsets.only(right: 6),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: current == index
                                ? kBlueColor
                                : kTwentyBlueColor),
                      );
                    },
                  ),
                )
              ],
            ),
          ),

          Container(
            height: 200,
            width: 300,
            child: ListView.builder(
              itemCount: datas.length,
              padding: EdgeInsets.only(left: 16),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      current = index;
                    });
                    if (current == 4) {
                      Navigator.of(context).push(
                          CupertinoPageRoute(builder: (ctx) => NoteList()));
                    } else if (current == 0) {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (ctx) => MedicalCategory()));
                    } else if (current == 1) {
                      Navigator.of(context).push(
                          CupertinoPageRoute(builder: (ctx) => InputPage()));
                    } else if (current == 3) {
                      Navigator.of(context).push(
                          CupertinoPageRoute(builder: (ctx) => CovidScreen()));
                    } else if (current == 2) {
                      Navigator.of(context).push(
                          CupertinoPageRoute(builder: (ctx) => LoadNursing()));
                    }
                  },
                  child: OperationCard(
                    operation: datas[index].name,
                    selectedIcon: datas[index].selectedIcon,
                    unselectedIcon: datas[index].unselectedIcon,
                    isSelected: current == index,
                    context: this,
                  ),
                );
              },
            ),
          ),

          // Transaction Section
          Padding(
            padding: EdgeInsets.only(left: 16, bottom: 13, top: 29, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Social Media',
                  style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: kBlackColor),
                ),
                Text(
                  '',
                  style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: kBlackColor),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: FittedBox(
                fit: BoxFit.fill,
                alignment: Alignment.topCenter,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (ctx) => VideoList()));
                        BotToast.showNotification(
                            duration: Duration(seconds: 3),
                            leading: (error) {
                              return Icon(FontAwesomeIcons.sadCry);
                            },
                            title: (error) {
                              return Text("Not Available yet");
                            });
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                        ),
                        child: Container(
                          height: 150,
                          width: 200.0,
                          color: red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.youtubeSquare,
                                color: Colors.white,
                                size: 30,
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                'Youtube',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (ctx) => StudentPortal(
                              url: facebook,
                              name: name2,
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                        ),
                        child: Container(
                          height: 150.0,
                          width: 200.0,
                          color: blue,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.facebookSquare,
                                color: Colors.white,
                                size: 30,
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                'Facebook',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class OperationCard extends StatefulWidget {
  final String operation;
  final String selectedIcon;
  final String unselectedIcon;
  final bool isSelected;
  _ShowCaseState context;

  OperationCard(
      {this.operation,
      this.selectedIcon,
      this.unselectedIcon,
      this.isSelected,
      this.context});

  @override
  _OperationCardState createState() => _OperationCardState();
}

class _OperationCardState extends State<OperationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      width: 150,
      height: 123,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: kTenBlackColor,
              blurRadius: 10,
              spreadRadius: 5,
              offset: Offset(8.0, 8.0),
            )
          ],
          borderRadius: BorderRadius.circular(15),
          color: widget.isSelected ? kBlueColor : kWhiteColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
              widget.isSelected ? widget.selectedIcon : widget.unselectedIcon),
          SizedBox(
            height: 9,
          ),
          Text(
            widget.operation,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: widget.isSelected ? kWhiteColor : kBlueColor),
          )
        ],
      ),
    );
  }
}
