import 'get_all_product_model.dart';

class ProductDbModel {
  final int id;
  final String title;
  final double price;
  final String thumbnail;

  ProductDbModel({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
  });

  Map<String, dynamic> toDbMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'thumbnail': thumbnail,
    };
  }

  factory ProductDbModel.fromDbMap(Map<String, dynamic> map) {
    return ProductDbModel(
      id: map['id'] as int,
      title: map['title'] as String,
      price: (map['price'] as num).toDouble(),
      thumbnail: map['thumbnail'] as String,
    );
  }

  Product toProduct() {
    return Product(
      id: id,
      title: title,
      price: price,
      thumbnail: thumbnail,
      description: null,
      category: null,
      rating: null,
      stock: null,
      tags: null,
      brand: null,
      availabilityStatus: null,
      reviews: null,
      images: null,
    );
  }
}
