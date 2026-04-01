import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vendasagrindus/components/alert_button.dart';
import 'package:vendasagrindus/utilities/styles.dart';

class ResetPassword extends StatefulWidget {
  //Caixa de cadastro de usuário
  final Function popScreen;
  ResetPassword({required this.popScreen});
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool showSpinner = false;
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) widget.popScreen();
        },
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
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: kLogoColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    ),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      try {
                        setState(() {
                          showSpinner = true;
                        });
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: emailController.text);
                        ScaffoldMessenger.of(context).showSnackBar(
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
                        String message = e.toString();
                        if (e is FirebaseAuthException &&
                            e.code == 'user-not-found') {
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
  final String? label;
  final TextEditingController? controller;
  final Widget? trailingAction;

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
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          suffixIcon: trailingAction,
          labelText: label,
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade400,
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
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
    );
  }
}
