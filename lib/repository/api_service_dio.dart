import 'dart:convert';
import 'dart:developer';
import 'package:clean_mvvm_pattern/repository/api_end_point.dart';
import 'package:clean_mvvm_pattern/utils/routes/route_name.dart';
import 'package:clean_mvvm_pattern/view/auth/login_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../model/get_all_product_model.dart';
import '../model/me_model.dart';
import '../model/me_model.dart';
import '../view_model/auth/get_storage.dart';
import '../view_model/auth/token_store_provider.dart';



class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiEndPont.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  /// Optional: Interceptors
  static void setupInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log('REQUEST [${options.method}] ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log('RESPONSE ${response.statusCode}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          log('ERROR ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }


  Future<Map<String, dynamic>?> login({required String username, required String password})async{
     String url = ApiEndPont.login;
     var payload = {
       "username" : username,
       "password" : password
     };
     log('Login URL : $url');
     try{
        final response = await dio.post(url, data: payload,);
        if(response.statusCode == 200 || response.statusCode == 201){
          log('Login successfully : ${response.data}');
          log('Response type : ${response.data.runtimeType}');
          return response.data;
        }else{
          log('Login Failed : ${response.data}');
          return null;
        }
     }on DioException catch(e){
       log('Login Error : $e');
       return null;
     }
  }


  Future<MeModel?> meProfile(BuildContext context)async{
        String url = ApiEndPont.me;

        final token = Provider.of<TokenStoreProvider>(context, listen: false);
          final accessToken = await token.getToken();

        if(accessToken == null){
          log('AccessToken is missing');
          return null;
        }
        log('Profile getMeApi Token : $accessToken');

        log('Me Profile URL : $url');

        try{
            Response response = await dio.get(url,
            options: Options(
              headers: {
                "Authorization" : "Bearer $accessToken",
                'Content-Type' : 'application/json'
              }
            )
            );

            if(response.statusCode == 200){
              log('Me Profile successfully : ${response.data}');
              return MeModel.fromJson(response.data);
            }else{
              log('Failed Me Profile : ${response.data}');
              return null;
            }
        }on DioException catch(e){
          if(e.response?.statusCode == 401){
            debugPrint("Token - Token expired Dio");
            await token.clearToken();
            if(context.mounted){
              Navigator.pushNamedAndRemoveUntil(context, RouteName.login, (route) => false);
            }
            return null;
          }
          log('Error Me Profile : $e');
          return null;
        }
  }


  Future<Map<String, dynamic>?> singleData()async{
    String url = ApiEndPont.getSingleProduct;
    log('Single Product URL: $url');
    try{
      Response response = await dio.get(url);
      if(response.statusCode == 200){
        log('Single data Fetch Successful: ${response.data}');
        return response.data;
      }else{
        log(' Failed to Single data Fetch : ${response.data}');
        return null;
      }
    }on DioException catch(e){
      log('Single data Error : $e');
      return null;
    }
  }


  Future<GetAllProductModel?> getAllProduct()async{
    String url = ApiEndPont.getProductList;
    log('All Product URL: $url');
    try{
      Response response = await dio.get(url);
       if(response.statusCode == 200){
         log('All Product data Fetch Successful: ${response.data}');
         return GetAllProductModel.fromJson(response.data);
       }else{
         log('Failed All Product data Fetch: ${response.data}');
         return null;
       }
    }catch(e){
      log('Error All Product data Fetch: $e');
      return null;
    }
  }


  Future<bool> deleteSingleProduct(String id)async{
    String url = ApiEndPont.getSingleProduct;
    log('Delete Single Product URL: $url');

    try{
      Response response = await dio.delete(url);
      if(response.statusCode == 200){
        log('Delete Single Product Post Successful : ${response.data}');
        return true;
      }else{
        log('Failed to Delete Single Product : ${response.data}');
        return false;
      }
    }catch(e){
      log(' Error Delete Single Product : $e');
      return false;
    }
  }


  Future<bool> updateSingleProduct(Map<String, dynamic> updateData)async{
    String url = ApiEndPont.getSingleProduct;

    try{
      Response response = await dio.put(url, data: updateData);

      if(response.statusCode == 200 || response.statusCode ==201){
        log('Update Single Product Post Successful : ${response.data}');
        return true;
      }else{
        log('Failed to Update Single Product : ${response.data}');
        return false;
      }
    }catch(e){
      log(' Error Update Single Product : $e');
      return false;
    }
  }


   Future<GetAllProductModel?> searchProductList(String query)async{
      String url = '${ApiEndPont.getProductList}/search?q=$query';
      log(' Search Fetching Product : $url');

      try{
        Response response = await dio.get(url);
        if(response.statusCode == 200 || response.statusCode == 201){
          log('Fetch Search Post Successful : ${response.data}');
          return GetAllProductModel.fromJson(response.data);
        }else{
          log('Failed to Fetch Product : ${response.data}');
          return null;
        }
      }catch(e){
        log(' Error Fetching Product : $e');
        return null;
      }
   }


  Future<Map<String, dynamic>?> createPost({
    required String title,
    required String description,
    required String categories,
    required String tags,
    required double price,
    required double stock,
    required double rating,
    required String thumbnail,
    })async{

    String url = ApiEndPont.postCreateProduct;

    log('Post Create Product URL : $url');

    var payload = {
      'title' : title,
      'description' : description,
      'categories' : categories,
      'tags' : tags,
      'price' : price,
      'stock' : stock,
      'rating' : rating,
      'thumbnail' : thumbnail
    };

    try{
      Response response = await dio.post(url, data: payload);

      if(response.statusCode == 200 || response.statusCode == 201){
        log('Create Product successfully : ${response.data}');
        return response.data;
      }else{
        log('Failed Create Product : ${response.data}');
        return null;
      }
    }on DioException catch(e){
      log(' Create Product Error : $e');
      return null;
    }
  }


}
