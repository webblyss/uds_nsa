import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsa_app/pages/component/quize/quize.dart';
import 'package:nsa_app/pages/component/video.dart';
import 'package:flutter_tts/flutter_tts.dart';

class DetailPage extends StatefulWidget {
  final snapshot;

  const DetailPage({Key key, this.snapshot}) : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final FlutterTts flutterTts = FlutterTts();
  speak() async {
    flutterTts.setLanguage("en-US");
    flutterTts.setProgressHandler((text, start, end, word) {});
    flutterTts.setPitch(1);
    flutterTts.setSpeechRate(0.5);
    flutterTts.speak(
        "${widget.snapshot.get("Title")}, 'Items Needed to perform ${widget.snapshot.get("Title")} .'${widget.snapshot.get("Requirements")}'.''please carefully follow the steps to perform the procedure.'${widget.snapshot.get("Steps")}");
  }

  bool isSpeaking = false;
  stopSpeak() {
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        stopSpeak();
        Navigator.pop(context);
      },
      child: new Scaffold(
        appBar: AppBar(
          leading: isSpeaking == true
              ? IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.pause),
                  onPressed: () {
                    setState(() {
                      this.isSpeaking = false;
                    });
                    stopSpeak();
                  },
                )
              : IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.play_arrow),
                  onPressed: () {
                    setState(() {
                      this.isSpeaking = true;
                    });
                    speak();
                    flutterTts.setCompletionHandler(() {
                      setState(() {
                        this.isSpeaking = false;
                      });
                    });
                  }),
          title: new Text(
            widget.snapshot.get("Title"),
            style: TextStyle(fontSize: 18.0),
          ),
          centerTitle: true,
          backgroundColor: Colors.pink,
          actions: [
            IconButton(
                icon: Icon(Icons.video_collection_sharp, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: (ctx) => ComponentVideoList(
                            video: widget.snapshot.get("link"),
                            topic: widget.snapshot.get("Title"),
                          )));
                })
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => Quize(
                        snapshot: widget.snapshot,
                      )));
            },
            child: Text("Test")),
        body: SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              widget.snapshot.get("Requirements").isEmpty ||
                      widget.snapshot.get("Requirements") == ''
                  ? SizedBox(
                      height: 0.0,
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      child: new Card(
                        color: Colors.amberAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "Requirements",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              for (var i = 0;
                  i < widget.snapshot.get("Requirements").length;
                  i++)
                widget.snapshot.get("Requirements") == null ||
                        widget.snapshot.get("Requirements") == ''
                    ? SizedBox(
                        height: 0.0,
                      )
                    : new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Text(
                                      "${i + 1}",
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  new SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: new Text(
                                        widget.snapshot.get("Requirements")[i],
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              new SizedBox(
                height: 20.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: new Card(
                  color: Colors.blueAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Procedures",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              for (var i = 0; i < widget.snapshot.get("Steps").length; i++)
                new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(
                                "${i + 1}",
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                            new SizedBox(
                              width: 5.0,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    8.0, 8.0, 8.0, 12.0),
                                child: new Text(
                                  widget.snapshot.get("Steps")[i],
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              new SizedBox(
                height: 20.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
