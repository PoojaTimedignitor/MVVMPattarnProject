import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/get_all_product_model.dart';


class GetProductFirestore {

  final _dbFirestore = FirebaseFirestore.instance;


  Future<void> saveApiDataToFirestore(GetAllProductModel data) async {
   final batch = _dbFirestore.batch();

    // for (var item in data.products) {
    //   await _dbFirestore
    //       .collection('services')
    //       .doc(item['id'].toString())
    //       .set(item, SetOptions(merge: true));
    // }

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


  Stream<List<Product>> getProductsData() {
    return FirebaseFirestore.instance
        .collection('products')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Product.fromJson(doc.data()))
          .toList();
    });
  }





}