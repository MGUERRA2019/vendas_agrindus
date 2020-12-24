import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:vendasagrindus/screens/login/signup_screen.dart';
import 'package:vendasagrindus/user_data.dart';
import 'package:vendasagrindus/utilities/constants.dart';

import '../navigation_screen.dart';

class NewLoginScreen extends StatefulWidget {
  @override
  _NewLoginScreenState createState() => _NewLoginScreenState();
}

class _NewLoginScreenState extends State<NewLoginScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
                SignIn(
                  changePage: () {
                    setState(() {
                      _tabController.index = 1;
                    });
                  },
                ),
                SignUpScreen(
                  popScreen: () {
                    setState(() {
                      _tabController.index = 0;
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

class SignIn extends StatefulWidget {
  final Function changePage;
  SignIn({@required this.changePage});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool showSpinner = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      opacity: 0.1,
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
            LoginInputBox(
              label: 'Endereço de e-mail',
              keyboard: TextInputType.emailAddress,
              controller: emailController,
            ),
            LoginInputBox(
              label: 'Senha',
              isPassword: true,
              controller: passwordController,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      'Esqueci minha senha',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: kPrimaryColor),
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
                      try {
                        setState(() {
                          showSpinner = true;
                        });
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
                          Navigator.pop(context);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NavigationScreen()),
                              (route) => false);
                        }
                      } on FirebaseAuthException catch (e) {
                        setState(() {
                          showSpinner = false;
                        });
                        passwordController.clear();
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      } catch (e) {
                        setState(() {
                          showSpinner = false;
                        });
                        passwordController.clear();
                        print(e);
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

class LoginInputBox extends StatelessWidget {
  final String label;
  final String inputHint;
  final bool isPassword;
  final TextInputType keyboard;
  final TextEditingController controller;
  LoginInputBox(
      {this.label,
      this.inputHint,
      this.isPassword = false,
      this.keyboard,
      this.controller});
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
