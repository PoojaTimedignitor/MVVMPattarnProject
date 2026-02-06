import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';



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
//   ///  FIXED
//   bool get isLoggedIn => getToken() != null;
// }







class TokenStore {
// class TokenStoreProvider extends ChangeNotifier {
  static final GetStorage _storage = GetStorage();

  static const String _firstNameKey = 'firstName';
  static const String _lastNameKey = 'lastName';
  static const String _accessTokenKey = 'accessToken';

  /// Getters
  static String? getFirstName() => _storage.read<String>(_firstNameKey);
  static String? getLastName() => _storage.read<String>(_lastNameKey);
  static String? getToken() => _storage.read<String>(_accessTokenKey);

  /// Setters
  static Future<void> saveToken({
    required String token,
    required String firstName,
    required String lastName,
  }) async {
    await _storage.write(_accessTokenKey, token);
    await _storage.write(_firstNameKey, firstName);
    await _storage.write(_lastNameKey, lastName);
  }

  /// Clear
  static Future<void> clearToken() async {
    await _storage.remove(_accessTokenKey);
    await _storage.remove(_firstNameKey);
    await _storage.remove(_lastNameKey);
  }
}

