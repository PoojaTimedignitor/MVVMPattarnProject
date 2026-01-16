import 'dart:convert';
import 'dart:developer';
import 'package:clean_mvvm_pattern/repository/api_end_point.dart';
import 'package:clean_mvvm_pattern/utils/routes/route_name.dart';
import 'package:clean_mvvm_pattern/view_model/auth/token_store_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../model/get_all_product_model.dart';
import '../model/me_model.dart';
import '../view_model/auth/get_storage.dart';


class ApiService{

  Future<Map<String, dynamic>?> postLogin({required String username, required String password})async{
    final url = Uri.parse(ApiEndPont.login);
    log('Login URL : $url');
    var payload = {
       "username" : username,
       "password" : password
     };
    try{
      final response = await http.post(
          url,
          headers: {
            "Content-Type" : "application/json"
          },
        body: jsonEncode(payload)
      );
       final data = jsonDecode(response.body);
      if(response.statusCode == 200){
        log('Login Successful : $data');
        return data;
      }else{
        log('Login Failed : $data');
        return null;
      }
    }catch(e){
      log('Exception Error : $e');
      return null;
    }
  }


  Future<MeModel?> getMeApi(BuildContext context)async{
  final url = Uri.parse(ApiEndPont.me);
  log('Profile Data getMeApi URL : $url');

  final tokenProvider = Provider.of<TokenStoreProvider>(context, listen: false);
    final accessToken =  await tokenProvider.getToken();
    if(accessToken == null){
       log('AccessToken is missing');
       return null;
     }
  log('Profile getMeApi Token : $accessToken');

  try{
    final res = await http.get(
        url,
      headers: {
          "Authorization" : "Bearer $accessToken",
          'Content-Type' : 'application/json'
      }
    );

    final data = jsonDecode(res.body);
    if (res.statusCode == 401) {
      debugPrint("Token - Token expired");
      await tokenProvider.clearToken();
      if(context.mounted){
        Navigator.pushNamedAndRemoveUntil(context, RouteName.login, (route) => false);
      }
       return null;
    }
    if(res.statusCode == 200){
      log('Me Api Response : $data');
      return MeModel.fromJson(data);
    }
  }catch(e){
    log('Exception Error : $e');
    return null;
   }
  return null;
  }


  Future<GetAllProductModel?> getAllProductList()async{
    final url = Uri.parse(ApiEndPont.getProductList);
    log('Get all Product List Url : $url');
    try{
      final res = await http.get(
          url,
        headers: {
          'Content-Type' : 'application/json'
        },
      );
      final data = jsonDecode(res.body);
      if(res.statusCode == 200){
        log('Get all Product List Response : $data');
        return GetAllProductModel.fromJson(data);
      }else{
        log('Error Get all Product List');
        return null;
      }
    }catch(e){
      log(' Exception Get all Product List  : $e');
      return null;
    }
  }


   Future<Map<String, dynamic>?> getSingleProduct()async{
   // Future<dynamic> getSingleProduct()async{
    final url = Uri.parse(ApiEndPont.getSingleProduct);
    log('Single Product List Url : $url');
    try{
      final res = await http.get(
          url,
        headers: {
            'Content-Type' : 'application/json'
        }
      );
      final Map<String, dynamic> data = jsonDecode(res.body);
      if(res.statusCode == 200){
        log('Response Single Product : $data ');
        return data;
      }else{
           log('Error Fetch Single Product data: $data ');
        return null;
      }
    }catch(e){
       log('Exception  Single Product : $e ');
       return null;
    }
  }



  Future<bool> updateProduct(Map<String, dynamic> updateData)async{
    final url = Uri.parse(ApiEndPont.getSingleProduct);
    log('Update Product List Url : $url');
    try{
       final res = await http.put(
           url,
         headers: {'Content-Type' : 'application/json'},
         body: jsonEncode(updateData)
       );
       final data = jsonDecode(res.body);
       if(res.statusCode == 200){
         log('Update Product Post Successful : $updateData');
         log('Update Product Post Successful : $data');
         return true;
       }else{
         log('Update Product Post Failed : $updateData');
         return false;
       }
    }catch(e){
      log('Exception : $e');
      return false;
    }
  }


  Future<bool> deleteProduct(String id)async{
    final url = Uri.parse(ApiEndPont.getSingleProduct);
    log('Delete Product post Url : $url');
    try{
      final res = await http.delete(url);
      if(res.statusCode == 200){
        log('Delete Product Post Successful : $res');
        return true;
      }else{
        log('Failed delete Product Post Successful : $res');
        return false;
      }
    }catch(e){
      log('Exception : $e');
      return false;
    }
  }


  Future<GetAllProductModel?> searchProduct(String query)async{
    final url = Uri.parse("${ApiEndPont.getProductList}/search?q=$query");
    log('Get Search all Product List Url : $url');
    try{
       final res = await http.get(url);
       final data = jsonDecode(res.body);
       if(res.statusCode == 200){
         log('Get Search all Product Successfully : $data');
         return GetAllProductModel.fromJson(data);
       }else{
         log('Get Search  Product Failed : $data');
         return null;
       }
    }catch(e){
      log('Exception : $e');
      return null;
    }
  }



  Future<Map<String, dynamic>?> postCreateProduct({
    required String title,
    required String description,
    required String categories,
    required String tags,
    required double price,
    required double stock,
    required double rating,
    required String thumbnail,
    //List<Image>images
  })async{

    final url = Uri.parse(ApiEndPont.postCreateProduct);
    log('Post Create Product URL : $url');

    var payload = {
      "title" : title,
      "description" : description,
      "categories" : categories,
      "tags" : tags,
      "price" : price,
      "stock" : stock,
      "rating" : rating,
      "thumbnail" : thumbnail
    };

    try{
      final res = await http.post(
          url,
        headers: {'Content-Type' : 'application/json'},
        body: jsonEncode(payload)
      );
      final data = jsonDecode(res.body);
      if(res.statusCode == 201){
        log(' Product Created Successfully : $data');
        return data;
      }else{
        log(' Product Created Failed : $data');
        return null;
      }
    }catch(e){
      log('Exception : $e');
      return null;
    }

  }


}