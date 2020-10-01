import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AlertButton extends DialogButton {
  final String label;
  final Function onTap;

  AlertButton({@required this.label, @required this.onTap});

  @override
  Function get onPressed => onTap;

  @override
  Widget get child => Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      );
  @override
  Color get color => Colors.blue;
  @override
  BorderRadius get radius => BorderRadius.circular(20.0);
  @override
  double get width => 150.0;
}
