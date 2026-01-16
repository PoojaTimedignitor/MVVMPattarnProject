
  import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{

   ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

   bool get isDarkMode => _themeMode  == ThemeMode.dark;

   void setTheme() {
     _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
     notifyListeners();
   }



   static final ThemeData lightTheme = ThemeData(
     brightness: Brightness.light,
     primaryColor: Colors.blue,
     scaffoldBackgroundColor: Colors.white,
     appBarTheme: const AppBarTheme(
       backgroundColor: Colors.blue,
       foregroundColor: Colors.white
     ),
     textTheme: const TextTheme(
       displayMedium: TextStyle(color: Colors.black)
     )
   );


   static final ThemeData darkTheme = ThemeData(
       brightness: Brightness.dark,
       primaryColor: Colors.blue,
       scaffoldBackgroundColor: Colors.black,
       appBarTheme: const AppBarTheme(
           backgroundColor: Colors.blue,
           foregroundColor: Colors.black
       ),
       textTheme: const TextTheme(
           displayMedium: TextStyle(color: Colors.white)
       )
   );




}