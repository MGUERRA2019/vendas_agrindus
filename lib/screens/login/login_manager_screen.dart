import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendasagrindus/screens/login/login_screen.dart';
import 'package:vendasagrindus/screens/navigation_screen.dart';
import 'package:vendasagrindus/user_data.dart';

class LoginManagerScreen extends StatefulWidget {
  @override
  _LoginManagerScreenState createState() => _LoginManagerScreenState();
}

class _LoginManagerScreenState extends State<LoginManagerScreen> {
  double opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    Future _login() async {
      User user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        setState(() {
          opacity = 1;
        });
        await Provider.of<UserData>(context, listen: false)
            .loginSetup(user.uid);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => NavigationScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    }

    return Scaffold(
      backgroundColor: Color(0xFF03447c),
      body: FutureBuilder(
        future: _login(),
        builder: (context, snapshot) {
          return Center(
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
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
