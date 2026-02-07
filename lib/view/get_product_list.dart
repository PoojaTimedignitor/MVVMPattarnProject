import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/get_all_product_model.dart';
import '../utils/custom/theme_app_color.dart';
import '../view_model/product_data_view_model.dart';

class GetProductList extends StatefulWidget {
  const GetProductList({super.key});

  @override
  State<GetProductList> createState() => _GetProductListState();
}

class _GetProductListState extends State<GetProductList> {

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<ProductDataProvider>(context, listen: false)
    //       .fetchAllProductList();
    // });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductDataProvider>().fetchAllProductList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.tertiaryColors,
        title: const Text('Get All Product List'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Consumer<ProductDataProvider>(
            builder: (context, value, child) {
              return StreamBuilder<List<Product>>(
                stream: value.productsStream,
                builder: (context, snapshot) {

                  // if (!snapshot.hasData && snapshot.connectionState == ConnectionState.waiting) {
                  //   return const Center(child: CircularProgressIndicator());
                  // }

                  if (!value.cacheReady) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No products found"));
                  }

                    final products = snapshot.data!;

                    return ListView.builder(
                        itemCount: products.length,
                        // itemCount: value.allProductModel?.products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          // final product = value.allProductModel?.products[index];
                          return Card(
                            elevation: 4,
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                          radius: 12, child: Text("${product.id}")),
                                    ],
                                  ),
                                  Image.network(
                                    "${product.thumbnail}",
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/img.png',
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                  //Text("${product?.category?.name}"),
                                  Text(
                                    product.category != null
                                        ? categoryValues.reverse[product.category]!
                                        : "",
                                  ),

                                  Text(
                                    "${product.title}",
                                    style: const TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                  Text("${product.description}"),
                                  Text("Brand : ${product.brand}"),
                                 // Text("Available : ${product?.availabilityStatus?.name}"),
                                  Text(
                                      "Available : ${availabilityStatusValues.reverse[product.availabilityStatus] ?? ""}"
                                  ),

                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 22,
                                        color: Colors.amber,
                                      ),
                                      Text(
                                        "${product.rating}",
                                        style: const TextStyle(fontSize: 17),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(" Price : ${product.price}"),
                                      Text(" Stock : ${product.stock}"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },


              );
            },
          )),
    );
  }
}
