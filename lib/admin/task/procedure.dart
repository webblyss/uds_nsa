import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nsa_app/admin/dashboard/desgn.dart';

// ignore: must_be_immutable
class Procedure extends StatefulWidget {
  String course;
  String topic;
  List requirement;
  String link;
  Procedure({
    Key key,
    this.course,
    this.topic,
    this.requirement,
    this.link,
  }) : super(key: key);
  @override
  _ProcedureState createState() => _ProcedureState();
}

class _ProcedureState extends State<Procedure> {
  Map map;
  //firestore collections

  final formKey = GlobalKey<FormState>();
  var procedure = TextEditingController();
  List<String> procedureItems = List();

  String proced;
  String input;
  @override
  void initState() {
    super.initState();
    // procedureItems.add(widget.editProcedure);
  }

  saveDB() {
    if (procedureItems == null || procedureItems.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            title: Text("Error",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                )),
            content: Builder(builder: (context) {
              var height = MediaQuery.of(context).size.height / 2;
              var width = MediaQuery.of(context).size.width / 2;
              return Container(
                height: height - 500,
                width: width - 200,
                child: new Text(
                  "Please add Task ",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              );
            }),
          );
        },
      );
      return false;
    } else {
      //save items to firestore db
      final db = FieldValue.arrayUnion(procedureItems);
      dynamic pro = FieldValue.arrayUnion(widget.requirement);
      final CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("Component_Task");
      Map<String, dynamic> demoData = {
        "Title": "${widget.topic}",
        "Steps": db,
        "Course": "${widget.course}",
        "link":"${widget.link}",
        "Requirements": pro,
      };
      collectionReference.doc("${widget.topic}").set(demoData);
      BotToast.showNotification(
        title: (cancelFunc) {
          return Text("Saved Successfully");
        },
      );
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Admin()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
            ),
            onPressed: saveDB,
          )
        ],
        title: Text(
          "Add procedure",
          style: TextStyle(fontSize: 15.0),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addRequirements,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: procedureItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            background: Container(
              color: Colors.red,
            ),
            key: Key(procedureItems[index]),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: ListTile(
                title: Text(
                  procedureItems[index],
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                procedureItems.removeAt(index);
              });
            },
          );
        },
      ),
    );
  }

  void _addRequirements() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          title: Text("Add Procedure"),
          content: Builder(builder: (context) {
            var height = MediaQuery.of(context).size.height / 2;
            var width = MediaQuery.of(context).size.height / 2;
            return Container(
              height: height - 200,
              width: width - 200,
              child: Form(
                key: formKey,
                child: Center(
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Explain procedure to Patient'),
                    enableSuggestions: true,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return 'Please enter text';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      proced = newValue;
                    },
                    controller: procedure,
                    onChanged: (String value) {
                      input = value;
                    },
                  ),
                ),
              ),
            );
          }),
          actions: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FlatButton(
                  padding: EdgeInsets.all(20),
                  onPressed: () {
                    Navigator.of(context).pop();
                    procedure.text = '';
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                FlatButton(
                  padding: EdgeInsets.all(20),
                  onPressed: () {
                    final form = formKey.currentState;
                    if (form.validate()) {
                      setState(() {
                        procedureItems.add(input + '.');
                        procedure.text = '';
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
