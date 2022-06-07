import 'package:flutter/material.dart';
import 'package:nsa_app/admin/task/procedure.dart';

class Requirements extends StatefulWidget {
  final topic;
  final course;
  final link;

  const Requirements({Key key, this.topic, this.course, this.link}) : super(key: key);
  @override
  _RequirementsState createState() => _RequirementsState();
}

class _RequirementsState extends State<Requirements> {
  final formKey = GlobalKey<FormState>();
  List<String> requirements = List();
  @override
  void initState() {
    super.initState();
    // procedureItems.add(widget.editProcedure);
  }

  String proced;
  String input;
  var procedure = TextEditingController();
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
          "Add Requirements",
          style: TextStyle(fontSize: 15.0),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addRequirements,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(Icons.add),
        ),
      ),
      body: ListView.builder(
        itemCount: requirements.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            background: Container(
              color: Colors.red,
            ),
            key: Key(requirements[index]),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    requirements[index],
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                requirements.removeAt(index);
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
          title: Text(
            "Add Procedure",
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
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
                    decoration: InputDecoration(hintText: 'Trolley,Cotton etc'),
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
                        requirements.add(input + '.');
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

  void saveDB() {
    if (requirements.isEmpty || requirements == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            title: Text("Alert",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.red)),
            content: Padding(
              padding: const EdgeInsets.all(20.0),
              child: new Text(
                "Requirements are added for easy understand\nand memorization of task.",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            actions: <Widget>[
              RaisedButton(
                padding: EdgeInsets.all(12),
                color: Colors.blue,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => Procedure(
                                topic: widget.topic,
                                course: widget.course,
                                requirement: requirements,
                              )),
                      (route) => false);
                },
                child: new Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              RaisedButton(
                padding: EdgeInsets.all(12),
                color: Colors.blue,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: new Text(
                  "Add",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Procedure(
                    topic: widget.topic,
                    course: widget.course,
                    requirement: requirements,
                    link:widget.link,
                  )));
    }
  }
}
