import 'dart:async';
import 'dart:developer';

import 'package:clean_mvvm_pattern/view_model/product_data_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../model/get_all_product_model.dart';


class GetProductFirestore {

  final _dbFirestore = FirebaseFirestore.instance;


  Future<void> saveApiDataToFirestore(GetAllProductModel data) async {
   final batch = _dbFirestore.batch();

      for (final product in data.products) {
     final docRef = _dbFirestore
         .collection('products')
         .doc(product.id.toString());

     batch.set(
       docRef,
       product.toJson(),
       SetOptions(merge: true),
     );
   }

   await batch.commit();
  }


  // Stream<List<Product>> getProductsData() {
  //   return _dbFirestore
  //       .collection('products')
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.docs
  //         .map((doc) => Product.fromJson(doc.data()))
  //         .toList();
  //   });
  // }

  ///

  // Stream<List<Product>> getProductsData(ProductDataProvider provider) {
  //   return _dbFirestore
  //       .collection('products')
  //       .orderBy('id')
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.docs.map((doc) {
  //       try {
  //         return Product.fromJson(doc.data());
  //       } catch (e) {
  //         log('Firestore parse error for doc ${doc.id}: $e');
  //         return null;
  //       }
  //     }).whereType<Product>().toList();
  //   });
  // }

  Stream<List<Product>> getProductsData(ProductDataProvider provider) {
    return _dbFirestore
        .collection('products')
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        provider.markCacheReady();
      }
      return snapshot.docs
          .map((doc) => Product.fromJson(doc.data()))
          .toList();
    });
  }


}





class FirestoreNetworkManager {
  static final FirestoreNetworkManager _instance =
  FirestoreNetworkManager._internal();

  factory FirestoreNetworkManager() => _instance;

  FirestoreNetworkManager._internal();

  StreamSubscription? _subscription;

  void startListening() {
    _subscription =
        Connectivity().onConnectivityChanged.listen((result) async {
          if (result == ConnectivityResult.none) {
            await FirebaseFirestore.instance.disableNetwork();
            print(" Firestore network disabled (offline)");
          } else {
            await FirebaseFirestore.instance.enableNetwork();
            print(" Firestore network enabled (online)");
          }
        });
  }

  void dispose() {
    _subscription?.cancel();
  }
}