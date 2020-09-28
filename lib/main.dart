import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vendasagrindus/screens/clientes/listaclientes.dart';
import 'package:vendasagrindus/screens/produtos/produtos.dart';
import 'package:vendasagrindus/screens/login/login.dart';
import 'package:vendasagrindus/theme/app_theme.dart';
import 'package:vendasagrindus/utilities/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SFA Agrindus',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          primaryColor: kPrimaryColor,
          accentColor: kPrimaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ListaClientes(),
        );
  }
}
