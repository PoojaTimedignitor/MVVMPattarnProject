import 'dart:developer';

import 'package:clean_mvvm_pattern/utils/custom/show_dialog.dart';
import 'package:clean_mvvm_pattern/utils/utils.dart';
import 'package:clean_mvvm_pattern/view_model/product_data_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/custom/text_form_field.dart';
import '../utils/custom/theme_app_color.dart';


class SingleProductView extends StatelessWidget {
  const SingleProductView({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductDataProvider>(context, listen: false).fetchSingleData();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.tertiaryColors,
        title: const Text('Single Product Data'),
      ),
      body: Consumer<ProductDataProvider>(
        builder: (context, value, child) {
          return  Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                            radius: 12,
                            child: Text("${value.data['id']}")
                        ),

                         Row(
                          children: [
                            InkWell(
                                onTap: () {
                                 showEditDialog(context, value.data);
                                },
                                child: const Icon(Icons.edit, color: AppColor.tertiaryColors,)
                            ),
                            const SizedBox(width: 5,),
                            InkWell(
                              onTap: (){
                                showDeleteDialog(context, value.data['id'].toString());
                                },
                                child: const Icon(Icons.delete, color:  AppColor.errorColors,)
                            ),
                          ],
                        )
                      ],
                    ),
                    //Image(image: NetworkImage("${value.data['thumbnail']}")),
                    Image.network(
                      value.data['thumbnail'] ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/img.png',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    Text("${value.data['title']}", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    Text("Brand : ${value.data['brand']}"),
                    Text("Category : ${value.data['category']}"),
                    Text("${value.data['description']}"),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 22, color: Colors.amber,),
                        Text("${value.data['rating']}"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(" Price : ${value.data['price']}"),
                        Text(" Stock : ${value.data['stock']}"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  void showDeleteDialog(BuildContext context, String productId)async{
    final provider = Provider.of<ProductDataProvider>(context, listen: false);

    showCustomDialog(
        context: context,
        title: 'Delete Product',
        message: 'Are you sure want to delete product',
        cancelText: 'Cancel',
        confirmText: 'Delete',
        icon: Icons.delete,
        iconColor: Colors.red,
        onConfirm: ()async{
          bool isDeleted = await provider.fetchDeleteData(productId);
            log('Deleted data : $isDeleted');
            if(isDeleted && context.mounted){
              Utils().showSnackBar(context, 'Deleted Product Successfully', type: MessageType.success);
                  Navigator.pop(context);
            }else{
              Utils().showSnackBar(context, 'Failed to Deleted Product', type: MessageType.error);
            }
        }
    );


    // bool? confirm = await showDialog<bool>(
    //     context: context,
    //     builder: (context){
    //       return AlertDialog(
    //         title:  const Text('Delete Product'),
    //         content: const Text('Are you sure want to delete product'),
    //         actions: [
    //           TextButton(onPressed: (){
    //             Navigator.pop(context, false);
    //             }, child: const Text('Cancel')),
    //
    //           TextButton(onPressed: (){
    //             Navigator.pop(context, true);
    //             }, child: const Text('Yes')),
    //         ],
    //       );
    //     }
    // );
    //
    // if(confirm == true){
    //   bool isDeleted = await provider.fetchDeleteData(productId);
    //   log('Deleted dataaaa : $isDeleted');
    //   if(isDeleted){
    //     Utils().showSnackBar(context, 'Product Deleted Successfully', type: MessageType.success);
    //     Navigator.pop(context);
    //   }else{
    //     Utils().showSnackBar(context, 'Product Deleted Failed', type: MessageType.error);
    //     Navigator.pop(context);
    //   }
    // }

  }



  void showEditDialog(BuildContext rootContext, Map<String, dynamic> data)async{

    final provider = Provider.of<ProductDataProvider>(rootContext, listen: false);

    final TextEditingController idController = TextEditingController(text: data['id'].toString());
    final TextEditingController titleController = TextEditingController(text: data['title']);
    final TextEditingController descriptionController = TextEditingController(text: data['description']);
    final TextEditingController brandController = TextEditingController(text: data['brand']);
    final TextEditingController stockController = TextEditingController(text: data['stock'].toString());
    final TextEditingController priceController = TextEditingController(text: data['price'].toString());
    final TextEditingController ratingController = TextEditingController(text: data['rating'].toString());

    showDialog(
        context: rootContext,
        builder: (dialogContext){
          return  AlertDialog(
            title: const Text('Update Product'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextField(
                      controller: idController,
                      hintText: 'Enter Id'
                  ),
                  CustomTextField(
                      controller: titleController,
                      hintText: 'Enter title'
                  ),
                  CustomTextField(
                      controller: brandController,
                      hintText: 'Enter Brand Name'
                  ),
                  CustomTextField(
                      controller: descriptionController,
                      hintText: 'Enter Description'
                  ),
                  CustomTextField(
                      controller: stockController,
                      hintText: 'Enter stock'
                  ),

                  CustomTextField(
                      controller: priceController,
                      hintText: 'Enter price'
                  ),

                  CustomTextField(
                      controller: ratingController,
                      hintText: 'Enter rating'
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){Navigator.pop(dialogContext);}, child: const Text('Cancel')),
              TextButton(
                  onPressed: ()async{
                    Navigator.pop(dialogContext);
                    Map<String, dynamic> updateData = {
                      'id' : idController.text,
                      'title' : titleController.text,
                      'description' : descriptionController.text,
                      'brand' : brandController.text,
                      'stock' : double.tryParse(stockController.text),
                      'price' : double.tryParse(priceController.text),
                      'rating' : double.tryParse(ratingController.text),
                      "thumbnail": data["thumbnail"],
                      "category": data["category"],
                    };
                    bool isUpdated = await provider.fetchUpdateData(updateData);
                    if(isUpdated && rootContext.mounted){
                      Utils().showSnackBar(rootContext, 'Product Updated Successfully', type: MessageType.success);
                      provider.data = updateData;
                    }else{
                      if(rootContext.mounted){
                        Utils().showSnackBar(rootContext, 'Product Updated to Failed', type: MessageType.error);
                      }
                    }
              }, child: const Text('Save')),
            ],
          );
        }
    );
  }


}
