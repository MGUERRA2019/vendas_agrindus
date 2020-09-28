import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme(this.context);

  final BuildContext context;

  ThemeData get defaultTheme => ThemeData(
      primaryColor: AppColors.primary,
      accentColor: AppColors.button,
      
      textTheme: GoogleFonts.muliTextTheme(
        Theme.of(context).textTheme,
        
      ),

      visualDensity: VisualDensity.adaptivePlatformDensity,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF73AEF5),
      ),
      buttonTheme: ButtonThemeData(
        height: 40,
        buttonColor: AppColors.button,
        //minWidth: double.infinity,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      textSelectionColor: AppColors.primary.withOpacity(0.4),
      colorScheme: ColorScheme(
          primary: AppColors.primary,
          primaryVariant: AppColors.primary,
          secondary: AppColors.button,
          secondaryVariant: AppColors.accent,
          surface: Colors.white,
          background: Colors.white,
          error: Colors.red,
          onPrimary: Colors.green,
          onSecondary: AppColors.accent,
          onSurface: Colors.white,
          onBackground: Colors.white,
          onError: Colors.red,
          brightness: Brightness.light),
          );

}
