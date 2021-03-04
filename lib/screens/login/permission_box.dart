import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vendasagrindus/components/alert_button.dart';
import 'package:vendasagrindus/data_helper.dart';
import 'package:vendasagrindus/utilities/constants.dart';
import '../navigation_screen.dart';

class PermissionBox extends StatefulWidget {
  //Caixa de cadastro de usuário
  final Function popScreen;
  final Function permissionFunction;
  PermissionBox({@required this.popScreen, @required this.permissionFunction});
  @override
  _PermissionBoxState createState() => _PermissionBoxState();
}

class _PermissionBoxState extends State<PermissionBox> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool hidePassword = true;
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: widget.popScreen,
        child: Form(
          key: formKey,
          autovalidateMode: _autoValidate,
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
                  PermissionInputBox(
                    label: 'Senha para cadastro',
                    isPassword: hidePassword,
                    controller: passwordController,
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
                      if (value != DataHelper().permissionPassword) {
                        return "Senha incorreta";
                      } else {
                        return null;
                      }
                    },
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    color: kLogoColor,
                    splashColor: Colors.white30,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (formKey.currentState.validate()) {
                        widget.permissionFunction();
                      }
                    },
                    child: Text(
                      'Começar cadastro',
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

class PermissionInputBox extends StatelessWidget {
  final String label;
  final bool isPassword;
  final Function(String) validator;
  final TextEditingController controller;
  final Widget trailingAction;

  PermissionInputBox(
      {this.label,
      this.isPassword = false,
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
        keyboardType: TextInputType.visiblePassword,
        validator: validator,
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
