import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vendasagrindus/components/alert_button.dart';
import 'package:vendasagrindus/utilities/constants.dart';

import '../../user_data.dart';
import '../navigation_screen.dart';

class SignInBox extends StatefulWidget {
  //Caixa de login do usuário
  final Function changePage;
  SignInBox({@required this.changePage});

  @override
  _SignInBoxState createState() => _SignInBoxState();
}

class _SignInBoxState extends State<SignInBox> {
  bool showSpinner = false;
  bool hidePassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      opacity: 0,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    'Olá',
                    style:
                        kHeaderText.copyWith(color: kLogoColor, fontSize: 40),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 40, bottom: 30),
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
              ],
            ),
            SizedBox(height: 35),
            SignInInputBox(
              label: 'Endereço de e-mail',
              keyboard: TextInputType.emailAddress,
              controller: emailController,
            ),
            SignInInputBox(
              label: 'Senha',
              isPassword: hidePassword,
              controller: passwordController,
              keyboard: TextInputType.visiblePassword,
              trailingAction: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: hidePassword ? Colors.grey[400] : kPrimaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: GestureDetector(
                      onTap: () {
                        var user = FirebaseAuth.instance.currentUser;
                        print(user);
                      },
                      child: Text(
                        'Esqueci minha senha',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: kPrimaryColor),
                      ),
                    ),
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    color: kLogoColor,
                    splashColor: Colors.white30,
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                    child: Container(
                      child: Text(
                        'Entrar',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      try {
                        setState(() {
                          showSpinner = true;
                        });
                        if (emailController.text == null ||
                            emailController.text == '' ||
                            passwordController.text == null ||
                            passwordController.text == '') {
                          throw FirebaseAuthException(
                              message: 'Os campos devem ser preenchidos',
                              code: 'empty-string');
                        }
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                        await Provider.of<UserData>(context, listen: false)
                            .loginSetup(userCredential.user.uid);
                        setState(() {
                          showSpinner = false;
                        });
                        if (Provider.of<UserData>(context, listen: false)
                                .vendedor
                                .vENDEDOR !=
                            null) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NavigationScreen()),
                              (route) => false);
                        }
                      } catch (e) {
                        setState(() {
                          showSpinner = false;
                        });
                        String message = e.message;
                        if (e is FirebaseAuthException) {
                          if (e.code == 'user-not-found') {
                            message = 'Usuário não cadastrado';
                          } else if (e.code == 'empty-string') {
                            message = 'Os campos devem ser preenchidos';
                          } else if (e.code == 'wrong-password') {
                            message = 'Senha incorreta para o usuário';
                          } else if (e.message ==
                              'com.google.firebase.FirebaseException: An internal error has occurred. [ Unable to resolve host "www.googleapis.com":No address associated with hostname ]') {
                            message =
                                'Houve uma falha de conexão da internet. Verifique se o seu dispositivo está conectado a uma rede e tente novamente.';
                          }
                        }

                        Alert(
                          context: context,
                          title: 'ERRO',
                          desc: message,
                          style: kAlertCardStyle,
                          buttons: [
                            AlertButton(
                                label: 'VOLTAR',
                                onTap: () {
                                  setState(() {
                                    passwordController.clear();
                                  });
                                  Navigator.pop(context);
                                })
                          ],
                        ).show();
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, right: 40),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  color: kLogoColor,
                  splashColor: Colors.white30,
                  onPressed: widget.changePage,
                  padding: EdgeInsets.all(12),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Cadastre-se',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        VerticalDivider(
                          color: Colors.white,
                          thickness: .75,
                          indent: .5,
                          endIndent: .5,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignInInputBox extends StatelessWidget {
  final String label;
  final String inputHint;
  final bool isPassword;
  final TextInputType keyboard;
  final TextEditingController controller;
  final IconButton trailingAction;
  SignInInputBox({
    this.label,
    this.inputHint,
    this.isPassword = false,
    this.keyboard,
    this.controller,
    this.trailingAction,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 50, bottom: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: Color(0xff8f9db5),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
          child: TextFormField(
            onEditingComplete: () {},
            style: TextStyle(
              fontSize: 16,
            ),
            obscureText: isPassword,
            keyboardType: keyboard,
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: trailingAction,
              hintText: inputHint,
              hintStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey[400],
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 22, horizontal: 25),
              focusColor: kPrimaryColor,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(27),
                borderSide: BorderSide(color: kPrimaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(27),
                borderSide: BorderSide(color: Colors.grey[350]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
