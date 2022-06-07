import 'package:flutter/material.dart';

class AboutApp extends StatefulWidget {
  @override
  _AboutAppState createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nsa App"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _aboutText(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _aboutText1(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _aboutText2(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _aboutText() {
    return Text(
        "This app was founded by Courage Admnistration 2020-2021 to serve the entire Nursing student populace.",style: TextStyle(fontSize: 18),);
  }

  Widget _aboutText1() {
    return Text(
        "The app has been develop with the aim of making learning easy and fun",style: TextStyle(fontSize: 18),);
  }

  Widget _aboutText2() {
    return Text("The app also contain features such as component task, Todo for taking Lectures note,Complain Box,Medical Abbreviations,Covid updates,BMI calculator and many more",style: TextStyle(fontSize: 18),);
  }
  
}
