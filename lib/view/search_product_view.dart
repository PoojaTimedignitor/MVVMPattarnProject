import 'package:clean_mvvm_pattern/view_model/product_data_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/custom/theme_app_color.dart';

class SearchProductView extends StatelessWidget {
  const SearchProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductDataProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.fetchAllProductList();
      provider.searchController.clear();
      provider.clearSort();
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.tertiaryColors,
        title: const Text('Search Product'),
      ),
      body: Consumer<ProductDataProvider>(
        builder: (context, provider, child) {
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 10,),
                TextFormField(
                  controller: provider.searchController,
                  onChanged: (query){
                    provider.fetchSearchData(query);
                  },
                  decoration: InputDecoration(
                      hintText: 'Search Product..',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: provider.searchController.text.isNotEmpty ? IconButton(onPressed: (){provider.searchController.clear();}, icon: const Icon(Icons.clear)) : null
                  ),
                ),

                const SizedBox(height: 10,),

                Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton<String>(
                              value: provider.selectedSort,
                              hint: const Row(
                                children: [
                                  Icon(Icons.sort),
                                  SizedBox(width: 20,),
                                  Text('Sort by')
                                ],
                              ),
                              underline: const SizedBox(),
                              isExpanded: true,
                              items: provider.sortOptions.entries.expand((entry)=> entry.value.map((order){
                                final group = entry.key;
                                return DropdownMenuItem(
                                    value: "$group|$order",
                                    child: Text("$group : $order")
                                );
                              })).toList(),
                              onChanged: (value){
                                if(value == null) return;
                                provider.setSelectedSort(value);
                                final parts = value.split("|");
                                provider.sortProduct(parts[0], parts[1]);
                              }
                          ),
                        ),
                      ),
                      //   },
                      // ),
                    ),
                  ],
                ),


                Expanded(
                  child: ListView.builder(
                      itemCount: provider.allProductModel?.products.length,
                      itemBuilder: (context, index){
                        final data = provider.allProductModel?.products[index];
                        return Card(
                          elevation: 6,
                          child: ListTile(
                            leading: data?.thumbnail != null &&
                                data!.thumbnail!.isNotEmpty
                                ? Image.network(
                              data.thumbnail ?? '',
                              errorBuilder: (_, e, ___) =>
                                  Image.asset("assets/img.png"),
                            )
                                : Image.asset("assets/img.png"),
                            title: Text(data?.title ?? ''),
                            subtitle: Text("₹${data?.price}"),
                          ),
                        );
                      }
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
