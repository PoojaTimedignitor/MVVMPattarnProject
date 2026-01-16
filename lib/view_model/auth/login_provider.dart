
import 'dart:developer';

import 'package:clean_mvvm_pattern/repository/api_service_dio.dart';
import 'package:clean_mvvm_pattern/utils/utils.dart';
import 'package:clean_mvvm_pattern/view_model/auth/token_store_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../model/me_model.dart';
import '../../repository/api_service_http.dart';
import '../../utils/routes/route_name.dart';
import 'get_storage.dart';

class LoginProvider extends ChangeNotifier {

  bool _isLoading = false;

  MeModel? _meModel;

  ApiService api = ApiService();
  DioClient apiDio = DioClient();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isLoading => _isLoading;
  MeModel? get meModel => _meModel;

  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordController => _passwordController;

  void setLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  set meModel(MeModel? value){
    _meModel = value;
    notifyListeners();
  }

  Future<bool> isValidate(BuildContext context)async{
   String username =  usernameController.text.trim();
    String password = passwordController.text.trim();
    if(username.isEmpty && password.isEmpty){
      Utils().showFlushBar(context, 'Please Enter Username and Password', type: MessageType.warning);
      return false;
    }
    if(username.isEmpty){
      Utils().showFlushBar(context, 'Please Enter Username', type: MessageType.error);
      return false;
    }
    if(password.isEmpty){
      Utils().showFlushBar(context, 'Please Enter Password', type: MessageType.error);
      return false;
    }
    return true;
  }



  Future<void> fetchLoginData(BuildContext context)async{
    if(!await isValidate(context)){
      return;
    }
    setLoading(true);
    final result = await apiDio.login(
    // final result = await api.postLogin(
       username : usernameController.text.trim(),
       password:  passwordController.text.trim()
    );
    setLoading(false);
    log('Response Login : $result');

    if (result == null || result['accessToken'] == null) {
      if(context.mounted){
        Utils().showSnackBar(context, "Login Failed", type: MessageType.error);
      }
      return;
    }

    if(context.mounted){
      final tokenStore = Provider.of<TokenStoreProvider>(context, listen: false);
      await tokenStore.saveToken(result['accessToken']);

      log('Store Token fetchLoginData : $tokenStore');
    }

    // if (context.mounted) {
    //   final tokenStore = Provider.of<TokenStoreProvider>(context, listen: false);
    //   await tokenStore.saveToken(
    //     token: result['accessToken'],
    //     firstName: result['firstName'],
    //     lastName: result['lastName'],
    //   );
    //   log('User data stored successfully : $tokenStore');
    // }


    if(context.mounted){
      Utils().showSnackBar(context, "Login Successful", type: MessageType.success);
      Navigator.pushNamedAndRemoveUntil(context, RouteName.home, (route) => false);
    }
    notifyListeners();

  }


  Future<void> getMeApiData(BuildContext context)async{
    setLoading(true);
    notifyListeners();
    // final result = await api.getMeApi(context);
    final result = await apiDio.meProfile(context);
    setLoading(false);
    notifyListeners();
    log('Response Me APi : $result');
    if(result != null){
      meModel = result;
      log('Profile Data fetch : $meModel');
    }else{
      meModel = null;
      log('Profile Data fetch Faileddd');
    }
  }



}
