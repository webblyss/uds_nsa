import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nsa_app/pages/component/quize/result.dart';
class Processing extends StatefulWidget {
  final snapshot;
  final List scoreList;
  final int result;

  const Processing({Key key, this.snapshot, this.scoreList,this.result}) : super(key: key);
  @override
  _ProcessingState createState() => _ProcessingState();
}

class _ProcessingState extends State<Processing> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 8), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) => Result(
                snapshot: widget.snapshot,
                listScore: widget.scoreList,
                result: widget.result,
              )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset("assets/images/load1.gif"),
      ),
    );
  }
}
