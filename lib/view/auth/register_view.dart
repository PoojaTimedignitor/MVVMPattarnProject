import 'package:clean_mvvm_pattern/utils/custom/text_form_field.dart';
import 'package:clean_mvvm_pattern/view_model/auth/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/custom/theme_app_color.dart';
import '../../utils/custom/round_button.dart';
import '../../utils/routes/route_name.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<RegisterProvider>(
          builder: (context, value, child) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: AppColor.secondaryColors)
              ),
              child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Register', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                const SizedBox(height: 10,),

                // TextFormField(
                //   controller: value.nameController,
                //   decoration: InputDecoration(
                //       hintText: 'Enter Name',
                //       hintStyle: TextStyle(color: AppColor.secondaryColors.withOpacity(0.5)),
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(10)
                //       )
                //   ),
                // ),

                CustomTextField(
                    controller: value.nameController,
                    hintText: 'Enter Name'
                ),

                const SizedBox(height: 10,),

                // TextFormField(
                //   controller: value.emailController,
                //   decoration: InputDecoration(
                //       hintText: 'Enter Email',
                //       hintStyle: TextStyle(color: AppColor.secondaryColors.withOpacity(0.5)),
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(10)
                //       )
                //   ),
                // ),

                CustomTextField(
                    controller: value.emailController,
                    hintText: 'Enter Email'
                ),

                const SizedBox(height: 10,),

                // TextFormField(
                //   controller: value.usernameController,
                //   decoration: InputDecoration(
                //       hintText: 'Enter Username',
                //       hintStyle: TextStyle(color: AppColor.secondaryColors.withOpacity(0.5)),
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(10)
                //       )
                //   ),
                // ),


                CustomTextField(
                    controller: value.usernameController,
                    hintText: 'Enter Username'
                ),

                const SizedBox(height: 10,),

                // TextFormField(
                //   controller: value.passwordController,
                //   decoration: InputDecoration(
                //       hintText: 'Enter Password',
                //       hintStyle: TextStyle(color: AppColor.secondaryColors.withOpacity(0.5)),
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(10)
                //       )
                //   ),
                // ),

                CustomTextField(
                    controller: value.passwordController,
                    hintText: 'Enter Password'
                ),

                const SizedBox(height: 20,),

                RoundButton(
                    title: 'Register',
                    loading: value.isLoading,
                    onPress: (){
                      Navigator.pushNamed(context, RouteName.home);
                    }
                ),

                const SizedBox(height: 20,),

                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, RouteName.login);
                  },
                  child: RichText(
                      text:  const TextSpan(
                          text: "Already have an  account?",style: TextStyle(color: Colors.black87),
                          children: [
                            TextSpan(
                                text: '  Log in', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)
                            )
                          ]
                      )
                  ),
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
