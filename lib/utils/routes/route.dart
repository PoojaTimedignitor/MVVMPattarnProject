import 'package:clean_mvvm_pattern/utils/routes/route_name.dart';
import 'package:clean_mvvm_pattern/view/auth/login_view.dart';
import 'package:clean_mvvm_pattern/view/auth/register_view.dart';
import 'package:clean_mvvm_pattern/view/auth/splash_view.dart';
import 'package:clean_mvvm_pattern/view/home_view.dart';
import 'package:flutter/material.dart';

class AppRoute{

  static Route<dynamic> generateRoute(RouteSettings settings){
     switch(settings.name){
       case RouteName.splash:
         return MaterialPageRoute(builder: (context)=> const SplashView());
       case RouteName.login:
         return MaterialPageRoute(builder: (context)=> const LoginView());
       case RouteName.register:
         return MaterialPageRoute(builder: (context)=> const RegisterView());
       case RouteName.home:
         return MaterialPageRoute(builder: (context)=> const HomeView());
       default :
         return MaterialPageRoute(builder: (_)=> const Scaffold(body: Center(child: Text('404\n No Page Found'))));
     }
  }

}