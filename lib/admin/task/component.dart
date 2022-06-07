import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nsa_app/admin/task/topic.dart';

class ComponentLoad extends StatefulWidget {
  @override
  _ComponentLoadState createState() => _ComponentLoadState();
}

class _ComponentLoadState extends State<ComponentLoad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Component Task"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => Topic()));
          },
          child: Icon(Icons.add)),
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
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    key: ValueKey(documentSnapshot),
                    dismissal: SlidableDismissal(
                        child: SlidableDrawerDismissal(),
                        onWillDismiss: (actionType) {
                          return showDialog<bool>(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Delete"),
                                  content: Text("Item will be Deleted"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                    ),
                                    FlatButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        documentSnapshot.reference.delete();
                                        Navigator.of(context).pop(true);
                                        Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text("Item deleted",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            backgroundColor: Colors.grey,
                                            duration: Duration(seconds: 10),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              });
                        }),
                    child: Card(
                      elevation: 7.0,
                      child: ListTile(
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailsPage(
                          //     snapshot: documentSnapshot,
                          //   )));
                        },
                        leading: CircleAvatar(
                          radius: 15,
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
                        trailing: Icon(Icons.chevron_right),
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
}
