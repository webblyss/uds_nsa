import 'package:flutter/material.dart';

class FontSizePickerDialog extends StatefulWidget {
  /// initial selection for the slider
  final double initialFontSize;

  const FontSizePickerDialog({Key key, this.initialFontSize}) : super(key: key);

  @override
  _FontSizePickerDialogState createState() => _FontSizePickerDialogState();
}

class _FontSizePickerDialogState extends State<FontSizePickerDialog> {
  /// current selection of the slider
  double _fontSize;
  double containerHeight = 50;
  int increment = 10;
  int decrement = 40;
  @override
  void initState() {
    super.initState();
    _fontSize = widget.initialFontSize;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${_fontSize.toStringAsFixed(0)} Font Size'),
      content: Container(
        height: containerHeight,
        child: Slider(
          value: _fontSize,
          min: 10,
          max: 40,
          divisions: 9,
          label: "change font",
          onChanged: (value) {
            setState(() {
              _fontSize = value;
            });
          },
        ),
      ),
      actions: <Widget>[
        // ignore: deprecated_member_use
        FlatButton(
          onPressed: () {
            // Use the second argument of Navigator.pop(...) to pass
            // back a result to the page that opened the dialog
            Navigator.pop(context, _fontSize);
          },
          child: Text('DONE'),
        )
      ],
    );
  }
}
