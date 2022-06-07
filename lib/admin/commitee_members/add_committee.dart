import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AddCommitee extends StatefulWidget {
  @override
  _AddCommiteeState createState() => _AddCommiteeState();
}

class _AddCommiteeState extends State<AddCommitee> {
  TextEditingController fullName = TextEditingController();
  TextEditingController exPosition = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  File _image;
  final formKey = GlobalKey<FormState>();
final picker = ImagePicker();
  String fullname;
  String phone;
  String position;
  String department;
  String selected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Committee Members"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              _selectYear("Select Year"),
              _name("Full Name"),
              _position("Position"),
              _phone("Phone Number"),
              _uploadPic("Upload Picture"),
              _bottomUpload(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomUpload(BuildContext context) {
    void upload() async {
      print("it");
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
      pictureData['FullName'] = fullname.toLowerCase();
      pictureData['Position'] = position.toUpperCase();
      pictureData['Phone'] = phone.toUpperCase();
      pictureData['Year'] = selected.toUpperCase();
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection("Committee_Members").doc();
      await FirebaseFirestore.instance.runTransaction((transaction) {
        transaction.set(documentReference, pictureData);
        Navigator.pop(context);
      }).catchError((e) {
        print(e.toString());
        setState(() {
          fullName.text = '';
          exPosition.text = '';
        });
      });
    }

    uploadPicture() {
      final form = formKey.currentState;
      if (form.validate() && _image != null) {
        form.save();
        BotToast.showLoading(
          allowClick: false,
          crossPage: false,
        );
        upload();
      } else {
        BotToast.showNotification(
          duration: Duration(seconds: 5),
          crossPage: false,
          backgroundColor: Colors.black,
          title: (cancelFunc) {
            return Text(
              "Fill in Details",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w100),
            );
          },
        );
      }
    }

    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        FlatButton(
            child: Text(
              "Upload",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.purple,
            onPressed: () {
              uploadPicture();
            })
      ],
    );
  }

  Widget _selectYear(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        DropdownButtonFormField(
          hint: Text("select batch"),
          style: TextStyle(fontSize: 15.0, color: Colors.black),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'select year';
            }
            return null;
          },
          onSaved: (value) {
            department = value;
          },
          value: selected,
          items: [
            '2020-2021',
            '2021-2022',
            '2022-2023',
            '2023-2024',
            '2024-2025',
            '2025-2026',
            '2026-2027',
            '2027-2028',
            '2028-2029',
            '2029-2030',
          ]
              .map(
                (lable) => DropdownMenuItem(
                  child: Text(lable),
                  value: lable,
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              selected = value;
              print(selected);
            });
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Color(0xfff3f3f4),
            filled: true,
          ),
        ),
      ],
    );
  }

  Widget _name(String title) {
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
            controller: fullName,
            validator: (value) {
              if (value == null || value == '') {
                return "Fill in the section";
              } else {
                return null;
              }
            },
            onSaved: (newValue) {
              setState(() {
                fullname = newValue;
              });
            },
            onChanged: (value) {
              setState(() {
                fullname = value;
              });
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

  Widget _position(String title) {
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
            controller: exPosition,
            validator: (value) {
              if (value == null || value == '') {
                return "Fill in the section";
              } else {
                return null;
              }
            },
            onSaved: (newValue) {
              setState(() {
                position = newValue;
              });
            },
            onChanged: (value) {
              setState(() {
                position = value;
              });
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

  Widget _phone(String title) {
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
            keyboardType: TextInputType.phone,
            controller: phoneNumber,
            validator: (value) {
              if (value == null || value == '') {
                return "Fill in the section";
              } else {
                return null;
              }
            },
            onSaved: (newValue) {
              setState(() {
                phone = newValue;
              });
            },
            onChanged: (value) {
              setState(() {
                phone = value;
              });
            },
            decoration: InputDecoration(
              hintText: "WhatsApp contact",
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
            ),
          )
        ],
      ),
    );
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

  Widget _uploadPic(String title) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(
          height: 30,
        ),
        (_image != null)
            ? GestureDetector(
                onTap: getImage,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.brown,
                  backgroundImage: new FileImage(_image),
                ),
              )
            : GestureDetector(
                onTap: getImage,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.brown,
                  child: Icon(
                    Icons.camera_enhance,
                    color: Colors.white,
                  ),
                ),
              ),
      ],
    );
  }
}
