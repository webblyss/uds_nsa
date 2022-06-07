import 'package:flutter/material.dart';

import '../constants.dart';

class TopCard extends StatelessWidget {
  final IconData iconName;
  final String cardText;
  final Color iconColor;
  const TopCard({this.iconName, this.cardText, this.iconColor = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          iconName,
          size: 80.0,
          color: iconColor,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          cardText,
          style: kLabelTextStyle,
        ),
      ],
    );
  }
}
