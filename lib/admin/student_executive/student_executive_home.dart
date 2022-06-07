import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';

import 'add_excutive.dart';

class StudentExceutiveHome extends StatefulWidget {
  @override
  _StudentExceutiveHomeState createState() => _StudentExceutiveHomeState();
}

class _StudentExceutiveHomeState extends State<StudentExceutiveHome> {
  var green = Color(0xFF4caf6a);
  var greenLight = Color(0xFFd8ebde);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Executive"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => AddStudentExcutive()));
        },
        child: Icon(Icons.add),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Student_Executive")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          return StaggeredGridView.countBuilder(
            reverse: true,
            shrinkWrap: true,
            staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
            crossAxisCount: 4,
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot documentSnapshot = snapshot.data.docs[index];

              if (documentSnapshot.get("Image") != null) {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (
                          _,
                        ) {
                          return Container(
                              child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CachedNetworkImage(
                                imageUrl: documentSnapshot.get("Image"),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 25.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.green,
                                        child: Icon(
                                          FontAwesomeIcons.whatsapp,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      CircleAvatar(
                                        backgroundColor: Colors.pink,
                                        child: Icon(
                                          FontAwesomeIcons.envelope,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        child: Icon(
                                          FontAwesomeIcons.phone,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ));
                        });
                  },
                  child: Container(
                    
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          filterQuality: FilterQuality.high,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          imageUrl: documentSnapshot.get("Image"),
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            documentSnapshot
                                .get("FullName")
                                .toString()
                                .toUpperCase(),
                            style: TextStyle(
                                color: green, fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Card(
                          margin: EdgeInsets.all(12),
                          color: Colors.black54,
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text(
                                  documentSnapshot
                                      .get("Position")
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  documentSnapshot
                                      .get("Year")
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                 ElevatedButton(
                                  style: ButtonStyle(),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            "Delete Items?",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                          content: Text(
                                            "Are you sure you want to delete item?",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text("No",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .copyWith(
                                                          color:
                                                              Colors.purple)),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            FlatButton(
                                              child: Text("Yes",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1
                                                      .copyWith(
                                                          color:
                                                              Colors.purple)),
                                              onPressed: () {
                                                documentSnapshot.reference
                                                    .delete();

                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Text("Delete"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return SizedBox(width: 0);
              }
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
