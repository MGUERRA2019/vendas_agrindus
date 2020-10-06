import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AlertButton extends DialogButton {
  final String label;
  final Function onTap;
  final Color cor;
  final Color labelColor;
  final BoxBorder line;
  final bool hasGradient;

  AlertButton(
      {@required this.label,
      @required this.onTap,
      this.cor = Colors.blue,
      this.labelColor = Colors.white,
      this.line,
      this.hasGradient = true});

  Gradient gradientStyle() {
    return LinearGradient(
        colors: [Colors.blue, Colors.blueAccent[400]],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight);
  }

  @override
  Function get onPressed => onTap;

  @override
  Widget get child => Text(
        label,
        style: TextStyle(
          color: labelColor,
          fontSize: 20.0,
        ),
      );

  @override
  Gradient get gradient => hasGradient ? gradientStyle() : null;
  @override
  Color get color => cor;
  @override
  BorderRadius get radius => BorderRadius.circular(20.0);
  @override
  double get width => 150.0;
  @override
  BoxBorder get border => line;
}
