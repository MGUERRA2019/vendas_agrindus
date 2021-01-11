import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendasagrindus/utilities/constants.dart';

class ProfileBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 105,
          child: Stack(
            overflow: Overflow.visible,
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: kGradientStyle,
                ),
              ),
              Positioned(
                top: 65,
                left: 15,
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                    border: Border.all(width: 4, color: Colors.white),
                  ),
                  child: Icon(
                    Icons.account_circle,
                    size: 45,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 100,
          width: double.infinity,
          alignment: Alignment.topLeft,
          padding: EdgeInsets.fromLTRB(25, 55, 0, 0),
          child: Column(
            children: [
              Text(
                FirebaseAuth.instance.currentUser.displayName,
                style: kHeaderText.copyWith(color: Colors.grey[800]),
              ),
            ],
          ),
        )
      ],
    );
  }
}
