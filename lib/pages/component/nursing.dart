import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:photo_view/photo_view.dart';

import 'dbmanager.dart';
import 'detail.dart';

class LoadNursing extends StatefulWidget {
  @override
  _LoadNursingState createState() => _LoadNursingState();
}

class _LoadNursingState extends State<LoadNursing> {
  final DbStudentManager dbmanager = new DbStudentManager();
  Student student;
  List<Student> studlist;
  nested() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool inerBoxScrolled) {
        return <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 300,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Nursing Procedures",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              background: GestureDetector(
                onTap: () {
                  showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return Container(
                        child: PhotoView(
                          enableRotation: true,
                          imageProvider: AssetImage(
                            "assets/images/tai.jpg",
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Image.asset(
                  "assets/images/tai.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ];
      },
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("Component_Task").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                if (documentSnapshot.get("Course") == "Nursing procedure") {
                  return Card(
                    elevation: 7.0,
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => DetailPage(
                                  snapshot: documentSnapshot,
                                )));
                      },
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blue,
                        child: Text(
                          documentSnapshot.get("Title")[0],
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        documentSnapshot.get("Title"),
                        style: TextStyle(fontSize: 15.0),
                      ),
                      trailing: FavoriteButton(
                        iconSize: 40,
                        valueChanged: (_isFavorite) async {
                          List<dynamic> procedure =
                              documentSnapshot.get("Steps");
                          String json = jsonEncode(procedure);
                          String title =
                              documentSnapshot.get("Title").toString();
                          Student st = new Student(name: title, course: json);
                          if (_isFavorite == true) {
                            final player = AudioPlayer();
                            await player.setAsset('assets/sound/cutter2.m4a');
                            player.play();
                            dbmanager.insertStudent(st).then((id) {
                              print('Student Added to Db $id and $title');
                            });
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text("Added to favourite")));
                          } else {
                            dbmanager.deleteStudent(st.id);
                            print("deleted");
                          }
                        },
                      ),
                    ),
                  );
                }
                return new SizedBox(
                  width: 0.0,
                );
              },
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: nested(),
    );
  }
}
