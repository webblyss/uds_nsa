import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nsa_app/pages/bmi/components/bottom_button.dart';
import 'package:nsa_app/pages/bmi/components/reusable_card.dart';
import 'package:nsa_app/pages/bmi/constants.dart';


class Result extends StatefulWidget {
  final snapshot;
  final listScore;
  final int result;

  const Result({Key key, this.snapshot, this.listScore, this.result})
      : super(key: key);
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  final player = AudioPlayer();
  @override
  void initState() {
    super.initState();
    playSound();
  }

  playSound() async {
    if (widget.result > 20) {
      await player.setAsset("assets/sound/appluase.mp3");
      player.play();
    } else {
      await player.setAsset("assets/sound/try.mp3");
      player.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        player.stop();
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Result"),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                player.stop();
                Navigator.pop(context);
              }),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Center(
                // margin: EdgeInsets.only(left: 20.0),
                child: Text("Your Result", style: kResultTitleStyle),
              ),
            ),
            Expanded(
              flex: 5,
              child: ReusableCard(
                cardColor: kActiveCardColor,
                cardChild: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // Text(bmiInterpretation['result'].toUpperCase(),
                        //       style: kResultText),
                        Text(widget.result.toString(), style: lResultText),
                        Container(
                            padding: EdgeInsets.all(20.0),
                            child: widget.result > 40
                                ? Image.asset("assets/images/clab.gif")
                                : Image.asset("assets/images/sad.gif"))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            BottomButton(
              text: "DETAILS",
              onTap: () {
                Navigator.pop(context);
                player.stop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
