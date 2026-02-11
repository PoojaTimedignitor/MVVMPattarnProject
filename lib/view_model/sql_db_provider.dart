import 'dart:developer';

import 'package:clean_mvvm_pattern/model/product_db_model.dart';
import 'package:flutter/cupertino.dart';
import '../data_storage/sql_db/db_helper.dart';
import '../model/me_model.dart';
import '../repository/api_service_dio.dart';
import '../repository/api_service_http.dart';


class SqlDbProvider extends ChangeNotifier{

  List<MeModel> users = [];
  List<ProductDbModel> product = [];                       /// add 10-2-26
  bool isLoading = false;

  List<ProductDbModel> _allProducts = [];


  ApiService api = ApiService();
  DioClient apiDio = DioClient();

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> fetchUser()async{
    setLoading(true);
    notifyListeners();
    users  =  await DBHelper.instance.getUsers();
    setLoading(false);
    notifyListeners();
  }


   Future<void> addUser(MeModel user)async{
    await DBHelper.instance.addUser(user);
    fetchUser();
   }


   Future<void> deleteUser(int id)async{
    await DBHelper.instance.deleteUser(id);
    fetchUser();
   }


   /// Add Product Data 10-2-26

 Future<void> fetchProductData()async{
   setLoading(true);
    notifyListeners();
    product = await DBHelper.instance.fetchProducts();
   setLoading(false);
    notifyListeners();
 }

 Future<void> addProducts(List<ProductDbModel> product)async{
   await DBHelper.instance.insertProduct(product);
   await fetchProductData();
 }


}