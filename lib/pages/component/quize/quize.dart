import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'load.dart';

class Quize extends StatefulWidget {
  final snapshot;

  const Quize({Key key, this.snapshot}) : super(key: key);
  @override
  _QuizeState createState() => _QuizeState();
}

class _QuizeState extends State<Quize> {
  List<int> choice = [0, 1, 2, 3, 4];
  num sum = 0;
  num itemCount = 1;
  var procedureLenght;
  num totalSum;
  var round;

  // calc
  List<int> isSelected = [];
  List map = [];
  @override
  void initState() {
    isSelected = List.generate(
      widget.snapshot.get("Steps").length,
      (index) => 0,
    );

    isSelected.forEach((sum) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.snapshot.get('Title')),
        centerTitle: true,
      ),
      body: new Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              new Divider(
                color: Colors.grey,
              ),
              Flexible(
                child: new ListView(
                  children: <Widget>[
                    new Card(
                      child: new Column(
                        children: <Widget>[
                          new SizedBox(
                            height: 40.0,
                          ),
                          for (var i = 0;
                              i < widget.snapshot.get("Steps").length;
                              i++)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 7.0,
                                child: new Column(
                                  children: <Widget>[
                                    new ListTile(
                                      title: new Text(
                                        widget.snapshot.get("Steps")[i],
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                      trailing: new DropdownButton(
                                        value: isSelected[i],
                                        items: [
                                          for (final c in choice)
                                            DropdownMenuItem(
                                              child: Text(
                                                c.toString(),
                                                style:
                                                    TextStyle(fontSize: 15.0),
                                              ),
                                              value: c,
                                            ),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            isSelected[i] = value;

                                            print(isSelected);
                                            map.add({
                                              isSelected[i],
                                              widget.snapshot.get("Steps")[i],
                                            });
                                            print("this is $map");
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          new SizedBox(
                            height: 20.0,
                          ),
                          RaisedButton(
                            padding: EdgeInsets.all(8.0),
                            color: Colors.blue,
                            onPressed: _submit,
                            child: Text(
                              "Next",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          new SizedBox(
                            height: 30.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submit() {
    isSelected.forEach((num e) {
      sum += e;
    });
    for (var i = 0; i < widget.snapshot.get("Steps").length; i++) {
      procedureLenght = itemCount + i;
      print(i);
    }
    // ignore: non_constant_identifier_names
    int max_num = isSelected.isEmpty ? 0 : isSelected.reduce(max);
    round = max_num * procedureLenght;
    print("this is the score $round");
    print("this is the list $procedureLenght");

    // totalSum = (sum / procedureLenght) * 100;
    // print(procedureLenght);
    // round = totalSum.toStringAsFixed(2);
    // print(round);
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (ctx) => Processing(
          snapshot: widget.snapshot,
          scoreList: isSelected,
          result: round,
        ),
      ),
    );
  }
}
