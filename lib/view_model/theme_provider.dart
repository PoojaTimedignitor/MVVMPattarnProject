

  import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{

   ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

   bool get isDark => _themeMode  == ThemeMode.dark;

   // setThemeMode(themeMode){
   //  // _themeMode = themeMode;
   //    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
   //   notifyListeners();
   // }

   void setTheme() {
     _themeMode =
     _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
     notifyListeners();
   }

}