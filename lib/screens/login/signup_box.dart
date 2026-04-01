import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vendasagrindus/components/alert_button.dart';
import 'package:vendasagrindus/data_helper.dart';
import 'package:vendasagrindus/utilities/styles.dart';

import '../../user_data.dart';
import '../navigation_screen.dart';

class SignUpBox extends StatefulWidget {
  //Caixa de cadastro de usuário
  final Function popScreen;
  SignUpBox({required this.popScreen});
  @override
  _SignUpBoxState createState() => _SignUpBoxState();
}

class _SignUpBoxState extends State<SignUpBox> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool showSpinner = false;
  bool hidePassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController sellerCodeController = TextEditingController();

  Future<List<String>?> _getSellersList() async {
    //Verificação da existência do código de vendedor digitado pelo usuário.
    try {
      DataHelper db = DataHelper();
      List<String> vendedorList = [];
      Iterable jsonData = await db.getData(db.getVendedor,
          'http://189.57.124.26:8082/isapsfa/ISAPServerSFA.dll/datasnap/rest/TSM/');
      vendedorList =
          jsonData.map((model) => model['VENDEDOR'].toString()).toList();
      return vendedorList;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void _validateAccount() async {
    //Validação da conta e registro no Firebase Auth com email, senha.
    //Registro no Cloud Firestore do código do vendedor, tipo de uso e url (configurado como padrão o ip de homologação)
    if (formKey.currentState!.validate()) {
      try {
        setState(() {
          showSpinner = true;
        });
        List<String>? sellersList = await _getSellersList();
        if (sellersList != null &&
          sellersList.any((element) => element == sellerCodeController.text)) {
        print('All ok');

        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text,
                password: passwordController.text);
        await userCredential.user!.updateDisplayName(nameController.text);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'vendedor': sellerCodeController.text,
          'tipo': 'usuário',
          'url':
              'http://189.57.124.26:8082/isapsfa/ISAPServerSFA.dll/datasnap/rest/TSM/'
        });
        await Provider.of<UserData>(context, listen: false)
            .loginSetup(userCredential.user!.uid);
        setState(() {
          showSpinner = false;
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => NavigationScreen()),
            (route) => false);
      } else {
        throw Exception(
            'Código de vendedor não encontrado. Verifique o campo e tente novamente.');
      }
      } catch (e) {
        setState(() {
          showSpinner = false;
        });
        String message = e.toString();
        if (e is FirebaseAuthException) {
          if (e.code == 'weak-password') {
            print('The password provided is too weak.');
            message = 'Senha fornecida muito fraca.';
          } else if (e.code == 'email-already-in-use') {
            message = 'Endereço de email já cadastrado.';
            print('The account already exists for that email.');
          } else if ((e.message ?? '').contains('Unable to resolve host')) {
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
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) widget.popScreen();
        },
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
                  SignUpInputBox(
                    label: 'Endereço de e-mail',
                    inputHint: 'exemplo@agrindus.com.br',
                    keyboard: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      if (!EmailValidator.validate(value)) {
                        return 'Endereço de email não é válido';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SignUpInputBox(
                    label: 'Senha',
                    inputHint: 'Insira uma senha',
                    isPassword: hidePassword,
                    controller: passwordController,
                    keyboard: TextInputType.visiblePassword,
                    trailingAction: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: hidePassword ? Colors.grey.shade400 : kPrimaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        }),
                    validator: (value) {
                      if (value == null || value.length < 6) {
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
                  SignUpInputBox(
                    label: 'Nome',
                    inputHint: 'Insira seu nome e sobrenome',
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SignUpInputBox(
                    label: 'Código de vendedor',
                    inputHint: 'Insira seu código de vendedor',
                    keyboard: TextInputType.number,
                    controller: sellerCodeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
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
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: kLogoColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
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

class SignUpInputBox extends StatelessWidget {
  final String? label;
  final String? inputHint;
  final bool isPassword;
  final TextInputType? keyboard;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final Widget? trailingAction;

  SignUpInputBox(
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
