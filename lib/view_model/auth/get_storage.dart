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
//   Future<void> saveToken(
//      String token,
//      String firstName,
//      String lastName,
//   ) async {
//     await _storage.write(_accessTokenKey, token);
//     await _storage.write(_firstNameKey, firstName);
//     await _storage.write(_lastNameKey, lastName);
//
//     accessToken = token;
//     firstName = firstName;
//     lastName = lastName;
//     log('Saved token: $accessToken');
//     notifyListeners();
//   }
//
//
//   TokenStoreProvider() {
//     accessToken = _storage.read<String>(_accessTokenKey);
//     firstName = _storage.read<String>(_firstNameKey);
//     lastName = _storage.read<String>(_lastNameKey);
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


class TokenStoreGetStorage {
  final GetStorage _storage = GetStorage();

  /// Keys
  static const String tokenKey = 'accessToken';
  static const String firstNameKey = 'firstName';
  static const String lastNameKey = 'lastName';

  /// SAVE
  Future<void> saveToken({
    required String token,
    required String firstName,
    required String lastName,
  }) async {
    await _storage.write(tokenKey, token);
    await _storage.write(firstNameKey, firstName);
    await _storage.write(lastNameKey, lastName);
  }

  /// READ
  String? get token => _storage.read(tokenKey);
  String? get firstName => _storage.read(firstNameKey);
  String? get lastName => _storage.read(lastNameKey);

  /// CHECK LOGIN
  bool get isLoggedIn =>
      token != null && token!.isNotEmpty;

  /// LOGOUT
  Future<void> clearToken() async {
    await _storage.erase();
  }
}
