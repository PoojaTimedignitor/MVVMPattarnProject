import 'package:clean_mvvm_pattern/utils/custom/round_button.dart';
import 'package:clean_mvvm_pattern/view_model/product_data_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/custom/text_form_field.dart';
import '../utils/custom/theme_app_color.dart';

class CreateProductView extends StatelessWidget {
  const CreateProductView({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductDataProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.tertiaryColors,
        title: const Text('Create Product'),
      ),
      body: SingleChildScrollView(
        child: Consumer<ProductDataProvider>(
          builder: (context, value, child) {
            return  Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 21),
              decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // TextFormField(
                  //   controller: value.titleController,
                  //   decoration: InputDecoration(
                  //       hintText: 'Enter title',
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(15)
                  //       )
                  //   ),
                  // ),

                  CustomTextField(
                      controller: value.titleController,
                      hintText: 'Enter Title'
                  ),

                  const SizedBox(height: 15,),
                  // TextFormField(
                  //   controller: value.descriptionController,
                  //   decoration: InputDecoration(
                  //       hintText: 'Enter description',
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(15)
                  //       )
                  //   ),
                  // ),

                  CustomTextField(
                      controller: value.descriptionController,
                      hintText: 'Enter Description'
                  ),
                  const SizedBox(height: 15,),
                  // TextFormField(
                  //   controller: value.categoryController,
                  //   decoration: InputDecoration(
                  //       hintText: 'Enter category',
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(15)
                  //       )
                  //   ),
                  // ),
                  CustomTextField(
                      controller: value.categoryController,
                      hintText: 'Enter Category'
                  ),
                  const SizedBox(height: 15,),
                  // TextFormField(
                  //   controller: value.tagsController,
                  //   decoration: InputDecoration(
                  //       hintText: 'Enter tags',
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(15)
                  //       )
                  //   ),
                  // ),
                  CustomTextField(
                      controller: value.tagsController,
                      hintText: 'Enter Name'
                  ),
                  const SizedBox(height: 15,),
                  // TextFormField(
                  //   controller: value.priceController,
                  //   keyboardType: TextInputType.number,
                  //   decoration: InputDecoration(
                  //       hintText: 'Enter price',
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(15)
                  //       )
                  //   ),
                  // ),
                  CustomTextField(
                      controller: value.priceController,
                      keyboardType: TextInputType.number,
                      hintText: 'Enter Price'
                  ),
                  const SizedBox(height: 15,),
                  // TextFormField(
                  //   controller: value.ratingController,
                  //   keyboardType: TextInputType.number,
                  //   decoration: InputDecoration(
                  //       hintText: 'Enter rating',
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(15)
                  //       )
                  //   ),
                  // ),
                  CustomTextField(
                      controller: value.ratingController,
                      keyboardType: TextInputType.number,
                      hintText: 'Enter rating'
                  ),
                  const SizedBox(height: 15,),
                  // TextFormField(
                  //   controller: value.imageUrlController,
                  //   decoration: InputDecoration(
                  //       hintText: 'Enter image url',
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(15)
                  //       )
                  //   ),
                  // ),

                  CustomTextField(
                      controller: value.imageUrlController,
                      keyboardType: TextInputType.url,
                      hintText: 'Enter Image url'
                  ),

                  const SizedBox(height: 15,),

                  RoundButton(
                    title: 'Create Product',
                    loading: value.loading,
                    onPress: value.loading ? null : ()=> value.fetchCreateData(context)
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
