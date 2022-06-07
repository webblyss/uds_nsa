import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/material.dart';

import 'main_screen.dart';
import 'main_widget.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  var drawerKey = GlobalKey<SwipeDrawerState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // add this line so you can add your appBar in Body

      extendBodyBehindAppBar: true,
      body: SwipeDrawer(
        radius: 20,
        key: drawerKey,

        hasClone: false,
        bodyBackgroundPeekSize: 30,
        backgroundColor: Colors.purple,
        // pass drawer widget
        drawer: MenuWidget(
          drawerKey: drawerKey,
        ),
        // pass body widget
        child: ShowCase(
          drawerKey: drawerKey,
          
        ),
      ),
    );
  }
}
