import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vendasagrindus/components/alert_button.dart';
import 'package:vendasagrindus/screens/login/login_screen.dart';
import 'package:vendasagrindus/screens/navigation_screen.dart';
import 'package:vendasagrindus/user_data.dart';
import 'package:vendasagrindus/utilities/constants.dart';

class LoginManagerScreen extends StatefulWidget {
  //Splash Screen que determina se o usuário está logado ou não, redirecionando para o aplicativo ou tela de acesso/cadastro
  @override
  _LoginManagerScreenState createState() => _LoginManagerScreenState();
}

class _LoginManagerScreenState extends State<LoginManagerScreen> {
  double opacity = 0.0;
  void _login() async {
    User user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        opacity = 1;
      });
      try {
        await Provider.of<UserData>(context, listen: false)
            .loginSetup(user.uid);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => NavigationScreen()));
      } catch (e) {
        String message = e.message;
        if (e is SocketException) {
          message =
              'Houve uma falha de conexão da internet. Verifique se o seu dispositivo está conectado a uma rede e tente novamente.';
        }
        Alert(
          context: context,
          title: 'ERRO',
          desc:
              '$message Deseja desconectar? (Ao desconectar seus pedidos salvos serão perdidos)',
          style: kAlertCardStyle,
          buttons: [
            AlertButton(
                label: 'Não',
                line: Border.all(color: Colors.grey[600]),
                labelColor: Colors.grey[600],
                hasGradient: false,
                cor: Colors.white,
                onTap: () {
                  SystemNavigator
                      .pop(); //doesn't work with iOS (função não funciona com iOS)
                }),
            AlertButton(
                label: 'Sim',
                onTap: () async {
                  await Provider.of<UserData>(context, listen: false).signOut();
                  await FirebaseAuth.instance
                      .signOut()
                      .whenComplete(() => SystemNavigator.pop());
                }),
          ],
        ).show();
      }
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _login();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF03447c),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 36),
              width: 244,
              height: 110,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage('assets/logos/agrindusw.png'),
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 25),
            Opacity(
              opacity: opacity,
              child: CircularProgressIndicator(
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
