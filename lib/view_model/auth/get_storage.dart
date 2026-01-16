// import 'dart:developer';
// import 'package:get_storage/get_storage.dart';
// import 'package:flutter/material.dart';
//
//
// // class TokenStoreProvider extends ChangeNotifier{
// //
// //   final GetStorage _storage = GetStorage();
// //
// //   static const String _accessTokenKey = 'accessToken';
// //   static const String _firstNameKey = 'firstName';
// //   static const String _lastNameKey = 'lastName';
// //
// //   String? accessToken;
// //   String? firstname;
// //   String? lastname;
// //
// //
// //   ///  Setter
// //   Future<void> saveToken({required String token, required String firstName, required String lastName})async{
// //     await _storage.write(_accessTokenKey, token);
// //     await _storage.write(_firstNameKey, firstName);
// //     await _storage.write(_lastNameKey, lastName);
// //      accessToken = token;
// //      firstname = firstName;
// //      lastname = lastName;
// //     log('Save accessToken : $accessToken');
// //     notifyListeners();
// //   }
// //
// //     /// Getter
// //   String? getToken(){
// //     accessToken = _storage.read<String>(_accessTokenKey);
// //     log('Get accessToken : $accessToken');
// //      return accessToken;
// //   }
// //
// //   String? getFirstName() {
// //     firstname = _storage.read<String>(_firstNameKey);
// //     return firstname;
// //   }
// //
// //   String? getLastName(){
// //     lastname = _storage.read<String>(_lastNameKey);
// //     return lastname;
// //   }
// //
// //
// //    ///  Clear
// //   Future<void> clearToken()async{
// //     await _storage.remove(_accessTokenKey);
// //     await _storage.remove(_firstNameKey);
// //     await _storage.remove(_lastNameKey);
// //     accessToken = null;
// //     firstname = null;
// //     lastname = null;
// //     log('Remove accessToken : $accessToken');
// //       notifyListeners();
// //   }
// //
// //
// //  // bool get isLoggedIn => accessToken != null;
// //   bool get isLoggedIn => getToken() != null;
// //
// // //await _storage.erase();
// //
// // }
//
//
//
// class TokenStoreProvider extends ChangeNotifier {
//   final GetStorage _storage = GetStorage();
//
//   static const String _accessTokenKey = 'accessToken';
//   static const String _firstNameKey = 'firstName';
//   static const String _lastNameKey = 'lastName';
//
//   String? accessToken;
//   String? firstName;
//   String? lastName;
//
//   /// Save after login
//   Future<void> saveToken({
//     required String token,
//     required String firstName,
//     required String lastName,
//   }) async {
//     await _storage.write(_accessTokenKey, token);
//     await _storage.write(_firstNameKey, firstName);
//     await _storage.write(_lastNameKey, lastName);
//
//     accessToken = token;
//     this.firstName = firstName;
//     this.lastName = lastName;
//
//     log('Saved token: $accessToken');
//     notifyListeners();
//   }
//
//   /// Lazy-load from storage
//   String? getToken() {
//     accessToken ??= _storage.read<String>(_accessTokenKey);
//     return accessToken;
//   }
//
//   String? getFirstName() {
//     firstName ??= _storage.read<String>(_firstNameKey);
//     return firstName;
//   }
//
//   String? getLastName() {
//     lastName ??= _storage.read<String>(_lastNameKey);
//     return lastName;
//   }
//
//   /// Logout
//   Future<void> clearToken() async {
//     await _storage.remove(_accessTokenKey);
//     await _storage.remove(_firstNameKey);
//     await _storage.remove(_lastNameKey);
//
//     accessToken = null;
//     firstName = null;
//     lastName = null;
//
//     notifyListeners();
//   }
//
//   /// ✅ FIXED
//   bool get isLoggedIn => getToken() != null;
// }
//
//
//
//
// /*
//      import 'package:get_storage/get_storage.dart';
//
// class LocalUserStorage {
//   static final GetStorage _storage = GetStorage();
//
//   static const String _firstNameKey = 'firstName';
//   static const String _lastNameKey = 'lastName';
//   static const String _accessTokenKey = 'accessToken';
//
//   /// Getters
//   static String? getFName() => _storage.read<String>(_firstNameKey);
//   static String? getLName() => _storage.read<String>(_lastNameKey);
//   static String? getToken() => _storage.read<String>(_accessTokenKey);
//
//   /// Setters
//   static Future<void> saveUser({
//     required String token,
//     required String firstName,
//     required String lastName,
//   }) async {
//     await _storage.write(_accessTokenKey, token);
//     await _storage.write(_firstNameKey, firstName);
//     await _storage.write(_lastNameKey, lastName);
//   }
//
//   /// Clear
//   static Future<void> clear() async {
//     await _storage.remove(_accessTokenKey);
//     await _storage.remove(_firstNameKey);
//     await _storage.remove(_lastNameKey);
//   }
// }
//
//
//  */