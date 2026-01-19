//
// import 'dart:developer';
// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// class TokenStoreProvider extends ChangeNotifier {
//
//   String? accessToken;
//
//   Future<void> saveToken(String newToken)async {
//     final pref = await SharedPreferences.getInstance();
//      await pref.setString("accessToken", newToken);
//     accessToken = newToken;
//     log('Save accessToken : $accessToken');
//     notifyListeners();
//   }
//
//
//   Future<String?> getToken()async{
//     final pref = await SharedPreferences.getInstance();
//     accessToken = pref.getString("accessToken");
//     log('Get accessToken : $accessToken');
//     return accessToken;
//   }
//
//
//   Future<void> clearToken()async{
//     final pref = await SharedPreferences.getInstance();
//     await pref.remove("accessToken");
//     accessToken = null;
//     log('Remove accessToken : $accessToken');
//     notifyListeners();
//   }
//
//
//
// }