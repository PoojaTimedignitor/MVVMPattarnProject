
import 'package:clean_mvvm_pattern/sql_db/db_helper.dart';
import 'package:flutter/cupertino.dart';
import '../model/user_model.dart';


class SqlDbProvider extends ChangeNotifier{

  List<UserModel> users = [];
  bool isLoading = false;

  Future<void> fetchUser()async{
    isLoading = true;
    notifyListeners();

    users  =  await DBHelper.instance.getUsers();

    isLoading = false;
    notifyListeners();
  }


   Future<void> addUser(UserModel user)async{
    await DBHelper.instance.addUser(user);
    fetchUser();
   }


   Future<void> deleteUser(int id)async{
    await DBHelper.instance.deleteUser(id);
    fetchUser();
   }


}