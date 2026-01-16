import 'package:clean_mvvm_pattern/repository/api_service_dio.dart';
import 'package:clean_mvvm_pattern/utils/routes/route.dart';
import 'package:clean_mvvm_pattern/utils/routes/route_name.dart';
import 'package:clean_mvvm_pattern/view_model/auth/get_storage.dart';
import 'package:clean_mvvm_pattern/view_model/auth/login_provider.dart';
import 'package:clean_mvvm_pattern/view_model/auth/register_provider.dart';
import 'package:clean_mvvm_pattern/view_model/auth/token_store_provider.dart';
import 'package:clean_mvvm_pattern/view_model/product_data_view_model.dart';
import 'package:clean_mvvm_pattern/view_model/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
  DioClient.setupInterceptors();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
           ChangeNotifierProvider(create: (_) => LoginProvider()),
           ChangeNotifierProvider(create: (_) => RegisterProvider()),
           ChangeNotifierProvider(create: (_) => TokenStoreProvider()),
           ChangeNotifierProvider(create: (_) => ProductDataProvider()),
           ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
      child:  Consumer<ThemeProvider>(
        builder: (context, value, _) {
          final themeChanger = Provider.of<ThemeProvider>(context, listen: false);
          return  MaterialApp(
            themeMode: themeChanger.themeMode,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            // darkTheme: ThemeData(
            //   brightness: Brightness.dark
            // ),
            debugShowCheckedModeBanner: false,
            initialRoute: RouteName.splash,
            onGenerateRoute: AppRoute.generateRoute,
          );
        }
      ),
    );
  }
}






