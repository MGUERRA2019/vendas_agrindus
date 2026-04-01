import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AlertButton extends DialogButton {
  AlertButton({
    required String label,
    required void Function()? onTap,
    Color cor = Colors.blue,
    Color labelColor = Colors.white,
    BoxBorder? line,
    bool hasGradient = true,
  }) : super(
          child: Text(
            label,
            style: TextStyle(color: labelColor, fontSize: 20.0),
          ),
          onPressed: onTap,
          color: cor,
          gradient: hasGradient
              ? LinearGradient(
                  colors: [Colors.blue, Colors.blueAccent.shade400],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight)
              : null,
          radius: BorderRadius.circular(20.0),
          width: 150.0,
          border: line ?? const Border(),
        );
}
