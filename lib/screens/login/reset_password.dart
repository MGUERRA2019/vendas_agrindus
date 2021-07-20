import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vendasagrindus/components/alert_button.dart';
import 'package:vendasagrindus/utilities/constants.dart';

class ResetPassword extends StatefulWidget {
  //Caixa de cadastro de usuário
  final Function popScreen;
  ResetPassword({@required this.popScreen});
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool hidePassword = true;
  bool showSpinner = false;
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: widget.popScreen,
        child: ModalProgressHUD(
          opacity: .02,
          inAsyncCall: showSpinner,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: 140,
                  height: 90,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage('assets/logos/agrindus.png'),
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ResetPasswordInputBox(
                    label: 'Endereço de e-mail',
                    controller: emailController,
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    color: kLogoColor,
                    splashColor: Colors.white30,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      try {
                        setState(() {
                          showSpinner = true;
                        });
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: emailController.text);
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text('E-mail enviado com sucesso'),
                            duration: Duration(milliseconds: 1500),
                          ),
                        );
                        widget.popScreen();
                      } catch (e) {
                        setState(() {
                          showSpinner = false;
                        });
                        String message = e.message;
                        if (e.code == 'user-not-found') {
                          message = 'Usuário não cadastrado';
                        }
                        Alert(
                          context: context,
                          title: 'ERRO',
                          desc: message,
                          style: kAlertCardStyle,
                          buttons: [
                            AlertButton(
                              label: 'OK',
                              onTap: () {
                                setState(() {
                                  emailController.clear();
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ).show();
                      }
                    },
                    child: Text(
                      'Redefinir senha',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class ResetPasswordInputBox extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Widget trailingAction;

  ResetPasswordInputBox({this.label, this.controller, this.trailingAction});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
      child: TextFormField(
        style: TextStyle(
          fontSize: 16,
        ),
        controller: controller,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          suffixIcon: trailingAction,
          labelText: label,
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey[400],
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
          focusColor: kPrimaryColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(27),
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(27),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(27),
            borderSide: BorderSide(color: Colors.red),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(27),
            borderSide: BorderSide(color: Colors.grey[350]),
          ),
        ),
      ),
    );
  }
}
