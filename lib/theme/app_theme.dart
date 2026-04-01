import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme(this.context);

  final BuildContext context;

  ThemeData get defaultTheme => ThemeData(
      primaryColor: AppColors.primary,
      
      textTheme: GoogleFonts.mulishTextTheme(
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
      ), textSelectionTheme: TextSelectionThemeData(selectionColor: AppColors.primary.withValues(alpha: 0.4)), colorScheme: ColorScheme(
          primary: AppColors.primary,
          secondary: AppColors.button,
          surface: Colors.white,
          error: Colors.red,
          onPrimary: Colors.green,
          onSecondary: AppColors.accent,
          onSurface: Colors.white,
          onError: Colors.red,
          brightness: Brightness.light).copyWith(secondary: AppColors.button),
          );

}
