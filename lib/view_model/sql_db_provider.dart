
import 'package:clean_mvvm_pattern/sql_db/db_helper.dart';
import 'package:flutter/cupertino.dart';
import '../model/user_model.dart';


class SqlDbProvider extends ChangeNotifier{

  List<UserModel> products = [];
  bool isLoading = false;

  Future<void> fetchUser()async{
    isLoading = true;
    notifyListeners();

    products  =  await DBHelper.instance.getUsers();

    isLoading = false;
    notifyListeners();
  }


   Future<void> addUser(UserModel product)async{
    await DBHelper.instance.addUser(product);
    fetchUser();
   }


   Future<void> deleteUser(int id)async{
    await DBHelper.instance.deleteUser(id);
    fetchUser();
   }


}