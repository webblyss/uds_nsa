import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final Function onPressAction;

  RoundIconButton({@required this.icon, @required this.onPressAction});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressAction,
      child: Icon(
        icon,
        color: Colors.white,
      ),
      constraints: BoxConstraints.tightFor(width: 56.0, height: 56.0),
      elevation: 0.0,
      shape: CircleBorder(),
      fillColor: Color(0xFF4c4f5e),
    );
  }
}
