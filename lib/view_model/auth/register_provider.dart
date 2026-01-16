
import 'package:flutter/cupertino.dart';

class RegisterProvider extends ChangeNotifier {

  bool _isLoading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isLoading => _isLoading;

  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordController => _passwordController;

  void setLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

}
