
import 'dart:convert';

GetAllProductModel getAllProductListFromJson(String str) => GetAllProductModel.fromJson(json.decode(str));

String getAllProductListToJson(GetAllProductModel data) => json.encode(data.toJson());

class GetAllProductModel {
  List<Product> products;
  int total;
  int skip;
  int limit;

  GetAllProductModel({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory GetAllProductModel.fromJson(Map<String, dynamic> json) => GetAllProductModel(
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    total: json["total"],
    skip: json["skip"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "total": total,
    "skip": skip,
    "limit": limit,
  };
}

class Product {
  int? id;
  String? title;
  String? description;
  Category? category;
  double? price;
  double? rating;
  int? stock;
  List<String>? tags;
  String? brand;
  AvailabilityStatus? availabilityStatus;
  List<Review>? reviews;
  List<String>? images;
  String? thumbnail;

  Product({
    required this.id,
     this.title,
     this.description,
     this.category,
     this.price,
     this.rating,
     this.stock,
     this.tags,
    this.brand,
     this.availabilityStatus,
     this.reviews,
     this.images,
     this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"] ?? 0,
    title: json["title"],
    description: json["description"],
    category: categoryValues.map[json["category"]],
    price: (json["price"] ?? 0).toDouble(),                      //json["price"]?.toDouble(),
    rating: (json["rating"] ?? 0).toDouble(),                  //json["rating"]?.toDouble(),
    stock: json["stock"] ?? 0,
    // tags: List<String>.from(json["tags"].map((x) => x)),
    tags: (json["tags"] as List?)?.map((e) => e.toString()).toList(),

    brand: json["brand"],
    // availabilityStatus: availabilityStatusValues.map[json["availabilityStatus"]],
    // reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
    // images: List<String>.from(json["images"].map((x) => x)),
    availabilityStatus: availabilityStatusValues.map[json["availabilityStatus"]],
    reviews: (json["reviews"] as List?)?.map((x) => Review.fromJson(x)).toList(),
    images: (json["images"] as List?)?.map((e) => e.toString()).toList(),
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "category": categoryValues.reverse[category],
    "price": price,
    "rating": rating,
    "stock": stock,
    // "tags": List<dynamic>.from(tags.map((x) => x)),
    "tags": tags != null ? List<dynamic>.from(tags!) : [],
    "brand": brand,
    // "availabilityStatus": availabilityStatusValues.reverse[availabilityStatus],
    // "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
    // "images": List<dynamic>.from(images.map((x) => x)),
    "availabilityStatus": availabilityStatus != null
        ? availabilityStatusValues.reverse[availabilityStatus]
        : null,

    "reviews": reviews != null
        ? reviews!.map((x) => x.toJson()).toList()
        : [],

    "images": images != null
        ? List<dynamic>.from(images!)
        : [],
    "thumbnail": thumbnail,
  };
}

enum AvailabilityStatus {
  IN_STOCK,
  LOW_STOCK
}

final availabilityStatusValues = EnumValues({
  "In Stock": AvailabilityStatus.IN_STOCK,
  "Low Stock": AvailabilityStatus.LOW_STOCK
});

enum Category {
  BEAUTY,
  FRAGRANCES,
  FURNITURE,
  GROCERIES
}

final categoryValues = EnumValues({
  "beauty": Category.BEAUTY,
  "fragrances": Category.FRAGRANCES,
  "furniture": Category.FURNITURE,
  "groceries": Category.GROCERIES
});



class Review {
  int? rating;
  String comment;
  DateTime date;
  String reviewerName;
  String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    rating: json["rating"],
    comment: json["comment"],
    date: DateTime.parse(json["date"]),
    reviewerName: json["reviewerName"],
    reviewerEmail: json["reviewerEmail"],
  );

  Map<String, dynamic> toJson() => {
    "rating": rating,
    "comment": comment,
    "date": date.toIso8601String(),
    "reviewerName": reviewerName,
    "reviewerEmail": reviewerEmail,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
