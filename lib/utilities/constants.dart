import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final kAlertCardStyle = AlertStyle(
  animationType: AnimationType.shrink,
  backgroundColor: Colors.white,
  animationDuration: Duration(milliseconds: 200),
  isCloseButton: false,
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(50.0),
  ),
);

const kBackgroundColor = Color(0xFFF1EFF1);
const kPrimaryColor = Color(0xFF035AA6);
const kSecondaryColor = Color(0xFFFFA41B);
const kTextColor = Color(0xFF000839);
const kTextLightColor = Color(0xFF747474);
const kBlueColor = Color(0xFF40BAD5);

const kDefaultPadding = 20.0;

// our default Shadow
const kDefaultShadow = BoxShadow(
  offset: Offset(0, 15),
  blurRadius: 27,
  color: Colors.black12, // Black color with 12% opacity
);

const TextStyle kBottomNavyTextStyle = TextStyle(
  color: Colors.white,
);
