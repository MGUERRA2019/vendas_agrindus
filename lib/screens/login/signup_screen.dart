import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vendasagrindus/components/alert_button.dart';
import 'package:vendasagrindus/utilities/constants.dart';

class SignUpScreen extends StatefulWidget {
  final Function popScreen;
  SignUpScreen({@required this.popScreen});
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool showSpinner = false;
  bool hidePassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController sellerCodeController = TextEditingController();

  void _validateAccount() async {
    if (formKey.currentState.validate()) {
      print('All ok');
      try {
        setState(() {
          showSpinner = true;
        });
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        userCredential.user.updateProfile(displayName: nameController.text);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user.uid)
            .set({'vendedor': sellerCodeController.text});
        setState(() {
          showSpinner = false;
        });
        print('Register completed');
      } catch (e) {
        setState(() {
          showSpinner = false;
        });
        String message = e.toString();
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          message = 'Senha fornecida muito fraca.';
        } else if (e.code == 'email-already-in-use') {
          message = 'Endereço de email já cadastrado.';
          print('The account already exists for that email.');
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
                  emailController.clear();
                  passwordController.clear();
                });
                Navigator.pop(context);
              },
            ),
          ],
        ).show();
      }
    } else {
      setState(() {
        _autoValidate = AutovalidateMode.always;
        passwordController.clear();
      });
      print('Something wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: widget.popScreen,
        child: ModalProgressHUD(
          opacity: .02,
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              autovalidateMode: _autoValidate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
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
                  RegisterInputBox(
                    label: 'Endereço de email',
                    inputHint: 'exemplo@agrindus.com.br',
                    keyboard: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      if (!EmailValidator.validate(value)) {
                        return 'Endereço de email não é válido';
                      } else {
                        return null;
                      }
                    },
                  ),
                  RegisterInputBox(
                    label: 'Senha',
                    inputHint: 'Insira uma senha',
                    isPassword: hidePassword,
                    controller: passwordController,
                    keyboard: TextInputType.visiblePassword,
                    trailingAction: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          color:
                              hidePassword ? Colors.grey[400] : kPrimaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        }),
                    validator: (value) {
                      if (value.length < 6) {
                        return 'Senha menor que seis caracteres';
                      } else if (value.length > 15) {
                        return 'Senha maior que quinze caracteres';
                      } else if (!value.contains(RegExp('[0-9]')) ||
                          !value.contains(RegExp('[a-zA-Z]'))) {
                        return 'Obrigatório conter números e letras';
                      } else {
                        return null;
                      }
                    },
                  ),
                  RegisterInputBox(
                    label: 'Nome',
                    inputHint: 'Insira seu nome e sobrenome',
                    controller: nameController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Campo obrigatório';
                      } else {
                        return null;
                      }
                    },
                  ),
                  RegisterInputBox(
                    label: 'Código de vendedor',
                    inputHint: 'Insira seu código de vendedor',
                    keyboard: TextInputType.number,
                    controller: sellerCodeController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Campo obrigatório';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 40),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        color: kLogoColor,
                        splashColor: Colors.white30,
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        onPressed: () {
                          _validateAccount();
                        },
                        child: Text(
                          'Cadastrar',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class RegisterInputBox extends StatelessWidget {
  final String label;
  final String inputHint;
  final bool isPassword;
  final TextInputType keyboard;
  final Function(String) validator;
  final TextEditingController controller;
  final Widget trailingAction;

  RegisterInputBox(
      {this.label,
      this.inputHint,
      this.isPassword = false,
      this.keyboard,
      this.validator,
      this.controller,
      this.trailingAction});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
      child: TextFormField(
        style: TextStyle(
          fontSize: 16,
        ),
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboard,
        validator: validator,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          suffixIcon: trailingAction,
          labelText: label,
          hintText: inputHint,
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
