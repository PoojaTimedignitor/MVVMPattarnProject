import 'package:clean_mvvm_pattern/view_model/auth/token_store_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import '../../utils/routes/route_name.dart';
import '../../view_model/auth/get_storage.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();
    checkAuthentication();
  }

  void checkAuthentication()async{
  //  final tokenStore = Provider.of<TokenStoreProvider>(context, listen: false);
    final tokenStore = TokenStoreGetStorage();
    final token = GetStorage().read('accessToken');

    // final token = await tokenStore.getToken();
   // String? token = tokenStore.token;
    print('Token  Store SPlash: $token');
    await Future.delayed(Duration.zero);

    // if (tokenStore.isLoggedIn) {
    //   Navigator.pushNamedAndRemoveUntil(
    //     context,
    //     RouteName.home,
    //         (route) => false,
    //   );

    if(token != null && token.isNotEmpty){
      Navigator.pushNamedAndRemoveUntil(context, RouteName.home, (route) => false);
    }else{
        Navigator.pushNamedAndRemoveUntil(context, RouteName.login, (route) => true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Splash Screen')),
    );
  }
}
