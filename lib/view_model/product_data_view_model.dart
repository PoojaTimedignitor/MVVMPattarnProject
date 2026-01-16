import 'dart:developer';
import 'package:clean_mvvm_pattern/repository/api_service_dio.dart';
import 'package:flutter/cupertino.dart';
import '../model/get_all_product_model.dart';
import '../repository/api_service_http.dart';
import '../utils/utils.dart';

class ProductDataProvider extends ChangeNotifier{

  GetAllProductModel? _allProductModel;                        /// Get All Product List

  Map<String, dynamic> _data = {};                             /// Single Product

  ApiService api = ApiService();
  DioClient apiDio = DioClient();

  bool _loading = false;
  String? _selectedSort;
  List<Product>? _originalList = [];

  final TextEditingController _searchController = TextEditingController();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  GetAllProductModel? get allProductModel => _allProductModel;

  TextEditingController get searchController => _searchController;

  TextEditingController get titleController => _titleController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get categoryController => _categoryController;
  TextEditingController get tagsController => _tagsController;
  TextEditingController get priceController => _priceController;
  TextEditingController get stockController => _stockController;
  TextEditingController get ratingController => _ratingController;
  TextEditingController get imageUrlController => _imageUrlController;


 bool get loading => _loading;
  Map<String, dynamic> get data => _data;
  String? get selectedSort => _selectedSort;
  List<Product>? get originalList => _originalList;


  final Map<String, List<String>> sortOptions = {
    "No Select" : ["None"],
    "Alphabetical": ["A-Z", "Z-A"],
    "Price": ["High to Low", "Low to High"],
  };

    set allProductModel(GetAllProductModel? value){
      _allProductModel = value;
      notifyListeners();
    }

    set data(Map<String, dynamic> value){
      _data = value;
      notifyListeners();
    }

     setLoading(bool value){
      _loading = value;
      notifyListeners();
    }

    void setSelectedSort(String? value){
      _selectedSort = value;
      notifyListeners();
    }

    void clearSort(){
     _selectedSort = null;
     notifyListeners();
    }

    Future<void> fetchAllProductList()async {
       final result = await apiDio.getAllProduct();
       // final result = await api.getAllProductList();
       allProductModel = result;
       _originalList = List<Product>.from(result?.products ?? []);
       notifyListeners();
       log('result All Product : $allProductModel');
    }


    Future<void> fetchSingleData()async{
      final response = await api.getSingleProduct();
      if(response != null){
             data = response;
             log('result Single Product : $data');
      }else{
          log('Response Single Product ius null');
      }
          notifyListeners();
    }


    Future<bool> fetchUpdateData(Map<String, dynamic> id)async{
      final result = await apiDio.updateSingleProduct(id);
      // final result = await api.updateProduct(id);
      notifyListeners();
      log('Update Post result : $result');
      return result;
    }


    Future<bool> fetchDeleteData(String id)async{
      final result = await apiDio.deleteSingleProduct(id);
      // final result = await api.deleteProduct(id);
      notifyListeners();
      log('Delete Post result : $result');
      return result;
    }

  ProductDataProvider() {
    searchController.addListener(() {
      notifyListeners();
    });
  }


    Future<void> fetchSearchData(String query)async{
      if(query.isEmpty){
        await fetchAllProductList();
        return;
      }
      final result = await apiDio.searchProductList(query);
      // final result = await api.searchProduct(query);
      log('Search Product Result : $result');
      _allProductModel = result;
      notifyListeners();
    }


  void sortProduct(String type, String order){
      if(_allProductModel == null) return;
      if(type == "No Select"){
        _allProductModel?.products = List<Product>.from(_originalList ?? []);
        notifyListeners();
        return;
      }
      List<Product> list = _allProductModel!.products;
      if(type == "Alphabetical"){
        list.sort((a, b) => a.title!.compareTo(b.title!));
        if(order == 'Z-A') list = list.reversed.toList();
      }
      if(type == "Price"){
        list.sort((a, b) => a.price.compareTo (b.price));
        if(order == "High to Low") list = list.reversed.toList();
      }
      _allProductModel?.products = list;
        notifyListeners();
  }


  bool isValidate(BuildContext context){
      String title = titleController.text.trim();
      String description = descriptionController.text.trim();
      String categories = categoryController.text.trim();
      String thumbnail = imageUrlController.text.trim();
      if(title.isEmpty || description.isEmpty || categories.isEmpty || thumbnail.isEmpty){
        Utils().showFlushBar(context, 'Please Fill some filled', type: MessageType.warning);
        return false;
      }
      return true;
  }


  Future<void> fetchCreateData(BuildContext context)async{
      if(!isValidate(context)){
        return;
      }
        setLoading(true);
        notifyListeners();
      final result = await apiDio.createPost(
      // final result = await api.postCreateProduct(
          title : titleController.text.trim(),
          description : descriptionController.text.trim(),
          categories : categoryController.text.trim(),
          tags : tagsController.text.trim(),
          price : double.tryParse(priceController.text.trim()) ?? 0.0,
          stock : double.tryParse(stockController.text.trim()) ?? 0.0,
          rating : double.tryParse(ratingController.text.trim()) ?? 0.0,
          thumbnail : imageUrlController.text.trim(),
      );
       setLoading(false);
       notifyListeners();
       log('Create data : $result');

      if(result != null){
        if(context.mounted){
          Utils().showSnackBar(context, 'Product Created Successfully', type: MessageType.success);
          Navigator.pop(context);
          titleController.clear();
          descriptionController.clear();
          categoryController.clear();
          tagsController.clear();
          priceController.clear();
          stockController.clear();
          ratingController.clear();
          imageUrlController.clear();
          setLoading(false);
          notifyListeners();
        }
      }else{
        if(context.mounted){
          Utils().showSnackBar(context, 'Product Created Failed', type: MessageType.error);
        }
        setLoading(false);
        notifyListeners();
      }
  }


}