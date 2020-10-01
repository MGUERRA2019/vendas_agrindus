import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vendasagrindus/data_helper.dart';
import 'package:vendasagrindus/model/vendedor.dart';
import 'package:vendasagrindus/screens/clientes/lista_clientes.dart';
import 'package:vendasagrindus/screens/login/login_widgets.dart';
import 'package:vendasagrindus/utilities/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vendasagrindus/components/alert_button.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _db = DataHelper();
  TextEditingController loginIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Vendedor vendedor = Vendedor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 75.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 240,
                        height: 90,
                        decoration: BoxDecoration(
                          //color: Colors.white24,
                          image: DecorationImage(
                            image: ExactAssetImage('assets/logos/agrindus.png'),
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Entrar',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      LoginTextBox(
                        controller: loginIdController,
                        fieldTitle: 'Codigo do Vendedor',
                        hintText: 'Entre com seu Codigo',
                        icon: Icons.people,
                        inputType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      LoginTextBox(
                        controller: passwordController,
                        fieldTitle: 'Senha',
                        hintText: 'Entre com sua Senha',
                        obscureText: true,
                        icon: Icons.lock,
                      ),
                      LoginButton(onPressed: () async {
                        FocusScope.of(context).unfocus();
                        try {
                          String id = loginIdController.text;
                          var dadosVendedor = await _db.getVendedor(id);
                          setState(() {
                            vendedor = Vendedor.fromJson(dadosVendedor[0]);
                          });
                          if (vendedor.vENDEDOR != null) {
                            print(vendedor.nOMECONH);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ListaClientes(vendedor: vendedor)),
                                (route) => false);
                          }
                        } catch (e) {
                          String message = e.toString();
                          if (vendedor.vENDEDOR == null) {
                            message = 'Código de vendedor não encontrado';
                          }
                          Alert(
                            context: context,
                            title: 'ERRO',
                            desc: message,
                            style: kAlertCardStyle,
                            buttons: [
                              AlertButton(
                                  label: 'RETURN',
                                  onTap: () {
                                    Navigator.pop(context);
                                  })
                            ],
                          ).show();
                        }
                      }),
                      ForgotPassword(
                        onTap: () => print('Forgot Password Button Pressed'),
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => print('Login Button Pressed'),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
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

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Sign in with',
          style: kLabelStyle,
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () => print('Login with Facebook'),
            AssetImage(
              'assets/logos/facebook.jpg',
            ),
          ),
          _buildSocialBtn(
            () => print('Login with Google'),
            AssetImage(
              'assets/logos/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => print('Sign Up Button Pressed'),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//async {
//   String id = loginIdController.text;
//   print('Login Button Pressed');
//   var result = await _db.getVendedor(id);

// },
