import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nsa_app/admin/bezierContainer.dart';
import 'package:nsa_app/home/dashboard.dart';
import 'package:nsa_app/screens/loginUser.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  TextEditingController indexNumber = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  File _image;
  final picker = ImagePicker();

  Widget _entryField(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty || value == '') {
                return "Please Enter Index Number";
              }
              return null;
            },
            onSaved: (newValue) {
              indexNumber.text = newValue;
            },
            decoration: InputDecoration(
              hintText: "NU/****/**",
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _firstName(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: firstNameController,
            validator: (value) {
              if (value.isEmpty || value == '') {
                return "Please Enter First Name";
              }
              return null;
            },
            onSaved: (newValue) {
              firstNameController.text = newValue;
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _lastName(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: lastNameController,
            validator: (value) {
              if (value.isEmpty || value == '') {
                return "Please Enter last Name";
              }
              return null;
            },
            onSaved: (newValue) {
              lastNameController.text = newValue;
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _password(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: passwordController,
            validator: (value) {
              if (value.isEmpty || value == '') {
                return "Please Enter password";
              }
              return null;
            },
            onSaved: (newValue) {
              passwordController.text = newValue;
            },
            onTap: () {
              BotToast.showNotification(
                duration: Duration(seconds: 30),
                leading: (callback) {
                  return Icon(Icons.info);
                },
                title: (cancelFunc) {
                  return Text("Default Password is =  university");
                },
              );
            },
            obscureText: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        authenticate(context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          'Create Account',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _alreadyUser(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (ctx) => AlreadyUser()),
            (route) => false);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.green, Colors.blue])),
        child: Text(
          'Already a User?',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('Photo'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _logo() {
    return CircleAvatar(
      radius: 50,
      backgroundImage: AssetImage("assets/icon/icon.png"),
    );
  }

  Widget _title(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'U',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'DS-',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'NSA',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  Widget uploadPic() {
    return GestureDetector(
      onTap: () async {
        getImage();
      },
      child: CircleAvatar(
        radius: 50,
        backgroundImage: _image == null ? null : FileImage(_image),
        backgroundColor: Colors.blue,
        child: _image == null ? Icon(Icons.camera_enhance) : SizedBox(width: 0),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          _entryField("Index Number"),
          _firstName("First Name"),
          _lastName("Last Name"),
          _password(
            "Password",
          ),
          _divider(),
          uploadPic(),
        ],
      ),
    );
  }

  void authenticate(BuildContext context) {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      _onLoading(context);
      FirebaseFirestore.instance
          .collection("student_login")
          .get()
          .then((QuerySnapshot data) {
        data.docs.forEach((element) async {
          if (element.get("ID") == indexNumber.text.toUpperCase() &&
              element.get("password") ==
                  passwordController.text.toLowerCase() && element.get("create")==false) {
// conde here
            String fileName = basename(_image.path);
            Reference storageReference =
                FirebaseStorage.instance.ref().child(fileName);
            UploadTask uploadTask = storageReference.putFile(_image);
            String url = await (await uploadTask).ref.getDownloadURL();
            uploadTask.whenComplete(() {
              print("done");
            });
            print(url);
            Map<String, dynamic> pictureData = new Map<String, dynamic>();
            pictureData['Image'] = (url != null) ? url : url;
            pictureData['FirstName'] = firstNameController.text.toLowerCase();
            pictureData['lastName'] = lastNameController.text.toUpperCase();
            pictureData['create'] = true;

// second code here
            element.reference.update(pictureData);
            _prefs.then((value) {
              value.setString(
                "userLastName",
                lastNameController.text,
              );
              value.setString(
                "userFirstName",
                firstNameController.text,
              );
              value.setString(
                "indexNumber",
                indexNumber.text,
              );
            });
            print("completed");
            Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(
                builder: (ctx) => DashBoard(),
              ),
              (route) => false,
            );
          } else {
            BotToast.showNotification(
                duration: Duration(seconds: 10),
                title: (event) {
                  return Text("Credentials does not match");
                });
          }
          print(element.get('password')[0]);
        });
      });
    }
  }

  Widget _alternate() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  void _onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new CircularProgressIndicator(),
              new Text("please wait"),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  _logo(),
                  _title(context),
                  SizedBox(height: 50),
                  _emailPasswordWidget(),
                  SizedBox(height: 20),
                  _submitButton(context),
                  SizedBox(height: 5),
                  _alternate(),
                  _alreadyUser(context),
                ],
              ),
            ),
          ),
          //  Positioned(top: 40, left: 0, child: _backButton()),
        ],
      ),
    ));
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
