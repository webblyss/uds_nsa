import 'package:flutter/material.dart';
import 'package:nsa_app/admin/task/requirement.dart';

class Topic extends StatefulWidget {
  @override
  _TopicState createState() => _TopicState();
}

class _TopicState extends State<Topic> {
  void _submit() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      print(topicInput);
      print(course);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Requirements(
            topic: topicInput,
            course: course,
            link:videoLink,
          ),
        ),
      );
    }
  }

  final formkey = GlobalKey<FormState>();
  TextEditingController topicController = TextEditingController();
    TextEditingController link = TextEditingController();

  String topicInput;
  String selected;
  String course;
  String videoLink;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Task",
          style: TextStyle(
            fontSize: 28.0,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: formkey,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new DropdownButtonFormField(
              style: TextStyle(fontSize: 15.0, color: Colors.black),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Select Program';
                }
                return null;
              },
              onSaved: (value) {
                course = value;
              },
              value: selected,
              items: [
                'Nursing procedure',
                'Midwifery procedure',
                'paediatric nursing'
              ]
                  .map((lable) => DropdownMenuItem(
                        child: Text(lable),
                        value: lable,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selected = value;
                  print(selected);
                });
              },
              decoration: InputDecoration(
                hintText: 'Course',
                hintStyle: TextStyle(fontSize: 15.0),
                labelText: 'Course',
                labelStyle: TextStyle(
                  fontSize: 15.0,
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(12.0)),
                prefixIcon: Icon(Icons.person),
                filled: true,
              ),
            ),
            new SizedBox(
              height: 20.0,
            ),
            new TextFormField(
              style: TextStyle(
                fontSize: 15.0,
              ),
              validator: (value) {
                if (value.isEmpty || value == null) {
                  return 'Please Enter Task';
                }
                return null;
              },
              onSaved: (newValue) {
                topicInput = newValue;
              },
              controller: topicController,
              decoration: InputDecoration(
                hintText: 'Input Task e.g Bed making',
                hintStyle: TextStyle(fontSize: 15.0),
                labelText: 'Task',
                labelStyle: TextStyle(
                  fontSize: 15.0,
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(12.0)),
                prefixIcon: Icon(Icons.person),
                filled: true,
              ),
            ),
            new SizedBox(
              height: 20.0,
            ),
             new TextFormField(
              style: TextStyle(
                fontSize: 15.0,
              ),
              validator: (value) {
                if (value.isEmpty || value == null) {
                  return 'Enter link';
                }
                return null;
              },
              onSaved: (newValue) {
                videoLink = newValue;
              },
              controller: link,
              decoration: InputDecoration(
                hintText: 'video link',
                hintStyle: TextStyle(fontSize: 15.0),
                labelText: 'paste video link here',
                labelStyle: TextStyle(
                  fontSize: 15.0,
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(12.0)),
                prefixIcon: Icon(Icons.video_collection),
                filled: true,
              ),
            ),
            new SizedBox(
              height: 20.0,
            ),
            new FlatButton(
              onPressed: _submit,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
