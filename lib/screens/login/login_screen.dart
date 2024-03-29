import 'package:flutter/material.dart';
import 'package:vendasagrindus/screens/login/permission_box.dart';
import 'package:vendasagrindus/screens/login/reset_password.dart';
import 'package:vendasagrindus/screens/login/signin_box.dart';
import 'package:vendasagrindus/screens/login/signup_box.dart';

class LoginScreen extends StatefulWidget {
  //Tela de login, as caixas de acesso/cadastro são estados diferentes controlados por abas que mudam com botão 'Cadastre-se' e 'Voltar'
  //Botão voltar necessário para futuros usuários de iOS
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.index = 1;
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/cow_bgjpeg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 545,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(45),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 7.5,
                  spreadRadius: .75,
                  color: Color(0x40000000),
                ),
              ],
            ),
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                ResetPassword(popScreen: () {
                  setState(() {
                    _tabController.index = 1;
                  });
                }),
                SignInBox(
                  changeToSignUpPage: () {
                    setState(() {
                      _tabController.index = 2;
                    });
                  },
                  changeToResetPassword: () {
                    setState(() {
                      _tabController.index = 0;
                    });
                  },
                ),
                PermissionBox(popScreen: () {
                  setState(() {
                    _tabController.index = 1;
                  });
                }, permissionFunction: () {
                  setState(() {
                    _tabController.index = 3;
                  });
                }),
                SignUpBox(
                  popScreen: () {
                    setState(() {
                      _tabController.index = 1;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
