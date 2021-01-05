import 'package:flutter/material.dart';
import 'package:vendasagrindus/utilities/constants.dart';

class LoginTextBox extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String fieldTitle;
  final String hintText;
  final IconData icon;
  final TextInputType inputType;

  LoginTextBox(
      {@required this.controller,
      @required this.fieldTitle,
      this.obscureText = false,
      this.hintText,
      this.icon,
      this.inputType});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          fieldTitle,
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: controller,
            keyboardType: inputType,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                icon,
                color: Colors.white,
              ),
              hintText: hintText,
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}

class ForgotPassword extends StatelessWidget {
  final Function onTap;
  final Alignment alignment;

  ForgotPassword({@required this.onTap, this.alignment});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          'Esqueceu sua senha?',
          style: kLabelStyle.copyWith(decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}

class RememberMeCheckbox extends StatelessWidget {
  final bool value;
  final Function onChanged;
  RememberMeCheckbox({@required this.onChanged, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: value,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: onChanged,
            ),
          ),
          Text(
            'Lembre-se de mim',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Function onPressed;
  final String buttonText;
  LoginButton({@required this.onPressed, @required this.buttonText});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: onPressed,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          buttonText,
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
