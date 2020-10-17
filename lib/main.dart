import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendasagrindus/user_data.dart';
import 'package:vendasagrindus/screens/login/login_screen.dart';
import 'package:vendasagrindus/utilities/constants.dart';
import 'screens/login/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SFA Agrindus',
        theme: ThemeData(
          textTheme: TextTheme(
              bodyText1:
                  TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500)),
          primaryColor: kPrimaryColor,
          accentColor: kPrimaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
