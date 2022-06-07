import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  final QueryDocumentSnapshot<Object> id;

  const ChangePassword({Key key, this.id}) : super(key: key);
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  // ignore: non_constant_identifier_names
  SharedPreferences sharedPreferences;
  TextEditingController change_password = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String password;
  final formKey = GlobalKey<FormState>();
  bool isTapped = true;
  bool enable = false;
  var savedBool;
  @override
  void initState() {
    super.initState();
    getBool();
    getData();
  }

  String indexNumber;
  getData() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((value) {
      setState(() {
        indexNumber = value.getString("indexNumber");
      });
    });
    print(indexNumber);
  }

  getBool() async {
    sharedPreferences = await SharedPreferences.getInstance();
    print(savedBool);
    setState(() {
      savedBool = sharedPreferences.getBool('set');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.lightGreen,
                child: Icon(
                  Icons.lock,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Reset your password to prevent others from login using your student ID and default password. If you encounter any trouble resetting your password please report a bug to us.",
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Turn on Security Notification"),
                  Switch(
                    value: savedBool == true ? true : false,
                    onChanged: (bool val) {
                      setState(() {
                        enable = val;
                      });
                      if (val == true) {
                        setState(() {
                          sharedPreferences.setBool("set", true);
                        });
                        BotToast.showText(text: "Security turned on");
                      } else {
                        setState(() {
                          sharedPreferences.setBool("set", false);
                        });
                        BotToast.showText(text: "Security turned off");
                      }
                    },
                    activeColor: Colors.green,
                    activeTrackColor: Colors.greenAccent[400],
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Text(
                    "Change Password",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                  key: formKey,
                  child: Stack(
                    children: [
                      TextFormField(
                        controller: change_password,
                        validator: (value) {
                          if (value == null || value == '') {
                            return "Fill in the section";
                          } else if (value.length < 6) {
                            return "Character too short";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          setState(() {
                            password = newValue;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color(0xfff3f3f4),
                          filled: true,
                        ),
                        obscureText: isTapped,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: isTapped == true
                            ? IconButton(
                                icon: Icon(FontAwesomeIcons.eyeSlash),
                                onPressed: () {
                                  setState(() {
                                    isTapped = false;
                                  });
                                },
                              )
                            : IconButton(
                                icon: Icon(FontAwesomeIcons.eye),
                                onPressed: () {
                                  setState(() {
                                    isTapped = true;
                                  });
                                },
                              ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                onPressed: changePassword,
                child: Text("Reset", style: TextStyle(color: Colors.white)),
                color: Colors.blue,
                padding: EdgeInsets.all(12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changePassword() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      try {
        BotToast.showLoading(
          crossPage: false,
          clickClose: false,
        );
        firebaseFirestore.collection("student_login").get().then((data) {
          data.docs.forEach((element) {
            if (element.get("ID").toString().toUpperCase() ==
                indexNumber.toUpperCase()) {
              element.reference.update({"password": "${change_password.text}"});
            }
          });
          BotToast.showText(
            crossPage: true,
            duration: Duration(seconds: 5),
            text: "Password Updated Successfully",
          );
          Navigator.pop(context);
        });
      } catch (e) {
        // BotToast.showNotification(title: e);
        print(e);
      }
    }
  }
}
