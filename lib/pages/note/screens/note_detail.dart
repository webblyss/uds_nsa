import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nsa_app/pages/note/db_helper/db_helper.dart';
import 'package:nsa_app/pages/note/modal_class/notes.dart';
import 'package:nsa_app/pages/note/utils/widgets.dart';

import 'enum.dart';

class NoteDetail extends StatefulWidget {
  final String appBarTitle;
  final Note note;

  NoteDetail(this.note, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return NoteDetailState(this.note, this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {
  DatabaseHelper helper = DatabaseHelper();
  FocusNode titleFocus = FocusNode();
  FocusNode contentFocus = FocusNode();
  String appBarTitle;
  Note note;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  int color;

  NoteDetailState(this.note, this.appBarTitle);
  bool isTapped = false;
  // ignore: unused_field
  int _value = 6;
  double _fontSize = 20.0;

  void _showFontSizePickerDialog() async {
    // <-- note the async keyword here

    // this will contain the result from Navigator.pop(context, result)
    final selectedFontSize = await showDialog<double>(
      context: context,
      builder: (context) => FontSizePickerDialog(initialFontSize: _fontSize),
    );

    // execution of this code continues when the dialog was closed (popped)

    // note that the result can also be null, so check it
    // (back button or pressed outside of the dialog)
    if (selectedFontSize != null) {
      setState(() {
        _fontSize = selectedFontSize;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    startTime() async {
      var _duration = new Duration(seconds: 15);
      return new Timer(_duration, () {
        if (isTapped == true) {
          setState(() {
            this.isTapped = false;
          });
        }
      });
    }

    startTime();

    titleController.text = note.title;
    descriptionController.text = note.description;
    color = note.color;
    return WillPopScope(
        onWillPop: () {
          showDiscardDialog(context);
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(appBarTitle, style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.brown,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () {
                  showDiscardDialog(context);
                }),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.save,
                  color: Colors.grey,
                ),
                onPressed: _save,
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.grey),
                onPressed: () {
                  showDeleteDialog(context);
                },
              ),
              IconButton(
                icon: Icon(Icons.settings, color: Colors.grey),
                onPressed: () {
                  _showFontSizePickerDialog();
                },
              )
            ],
          ),
          body: Stack(
            children: <Widget>[
              Container(
                color: colors[color],
                child: Column(
                  children: <Widget>[
                    PriorityPicker(
                      selectedIndex: 3 - note.priority,
                      onTap: (index) {
                        note.priority = 3 - index;
                      },
                    ),
                    ColorPicker(
                      selectedIndex: note.color,
                      onTap: (index) {
                        setState(() {
                          color = index;
                          print(colors[color]);
                        });
                        note.color = index;
                      },
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(16.0),
                    //   child: TextField(

                    //     controller: titleController,
                    //     style: TextStyle(fontSize: _fontSize),
                    //     onChanged: (value) {
                    //       updateTitle();
                    //     },
                    //     decoration: InputDecoration.collapsed(
                    //       hintText: 'Title',
                    //     ),
                    //     onTap: () {
                    //       setState(() {
                    //         this.isTapped = true;
                    //       });
                    //     },
                    //   ),
                    // ),

                    // Expanded(
                    //   child: Padding(
                    //     padding: EdgeInsets.all(16.0),
                    //     child: TextField(
                    //       keyboardType: TextInputType.multiline,
                    //       maxLines: 10,
                    //       controller: descriptionController,
                    //       style: TextStyle(fontSize: _fontSize),
                    //       onChanged: (value) {
                    //         updateDescription();
                    //       },
                    //       decoration: InputDecoration.collapsed(
                    //         hintText: 'Note',
                    //       ),
                    //       onTap: () {
                    //         setState(() {
                    //           this.isTapped = true;
                    //         });
                    //       },
                    //     ),
                    //   ),
                    // ),
                    ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          height: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                            focusNode: titleFocus,
                            autofocus: true,
                            controller: titleController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            onSubmitted: (text) {
                              titleFocus.unfocus();
                              FocusScope.of(context).requestFocus(contentFocus);
                            },
                            onChanged: (value) {
                              updateTitle();
                            },
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                                fontFamily: 'ZillaSlab',
                                fontSize: 32,
                                fontWeight: FontWeight.w700),
                            decoration: InputDecoration.collapsed(
                              hintText: 'Enter a title',
                              hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 32,
                                  fontFamily: 'ZillaSlab',
                                  fontWeight: FontWeight.w700),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                            focusNode: contentFocus,
                            controller: descriptionController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            onChanged: (value) {
                              updateDescription();
                            },
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                            decoration: InputDecoration.collapsed(
                              hintText: 'Start typing...',
                              hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                              border: InputBorder.none,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 20,
                top: 108,
                child: isTapped == true
                    ? Image.asset(
                        'assets/images/open.gif',
                        height: 80,
                        width: 80,
                      )
                    : Image.asset(
                        'assets/images/read.gif',
                        height: 80,
                        width: 80,
                      ),
              ),
            ],
          ),
        ));
  }

  void showDiscardDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Discard Changes?",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          content: Text(
            "Are you sure you want to discard changes?",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("No",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.purple)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Yes",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.purple)),
              onPressed: () {
                Navigator.of(context).pop();
                moveToLastScreen();
              },
            ),
          ],
        );
      },
    );
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Note?",
              style: Theme.of(context).textTheme.bodyText2),
          content: Text(
            "Are you sure you want to delete this note?",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("No",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.purple)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Yes",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.purple)),
              onPressed: () {
                Navigator.of(context).pop();
                _delete();
              },
            ),
          ],
        );
      },
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updateTitle() {
    note.title = titleController.text;
  }

  void updateDescription() {
    note.description = descriptionController.text;
  }

  // Save data to database
  void _save() async {
    moveToLastScreen();

    note.date = DateFormat.yMMMd().format(DateTime.now());

    if (note.id != null) {
      await helper.updateNote(note);
    } else {
      await helper.insertNote(note);
    }
  }

  void _delete() async {
    await helper.deleteNote(note.id);
    moveToLastScreen();
  }
}
