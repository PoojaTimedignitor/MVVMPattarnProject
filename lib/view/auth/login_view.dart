import 'package:clean_mvvm_pattern/utils/custom/round_button.dart';
import 'package:clean_mvvm_pattern/view_model/auth/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/custom/text_form_field.dart';
import '../../utils/custom/theme_app_color.dart';
import '../../utils/routes/route_name.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {

    ValueNotifier<bool> obSurePassword = ValueNotifier<bool>(true);

    return Scaffold(
      body: Center(
        child: Consumer<LoginProvider>(
          builder: (context, provider, child) {
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
                  const Text('Log in', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                  const SizedBox(height: 10,),

                  // TextFormField(
                  //   controller: provider.usernameController,
                  //   decoration: InputDecoration(
                  //       hintText: 'Enter Username',
                  //       hintStyle: TextStyle(color: AppColor.secondaryColors.withOpacity(0.5)),
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(10)
                  //       )
                  //   ),
                  // ),

                  CustomTextField(
                    controller: provider.usernameController,
                    hintText: 'Enter Username',
                  ),

                  const SizedBox(height: 10,),

                  ValueListenableBuilder<bool>(
                    valueListenable: obSurePassword,
                    builder: (context, obSure, child) {
                      return CustomTextField(
                          controller: provider.passwordController,
                          hintText: 'Enter Password',
                        obscureText: obSure,
                        suffixIcon: InkWell(
                          onTap: (){
                            obSurePassword.value = !obSurePassword.value;
                          },
                          child: Icon(obSure ? Icons.visibility_off : Icons.visibility),
                        ),
                      );

                      //   TextFormField(
                      //   controller: provider.passwordController,
                      //   obscureText: obSure,
                      //   obscuringCharacter: '*',
                      //   decoration: InputDecoration(
                      //       hintText: 'Enter Password',
                      //       suffixIcon: InkWell(
                      //           onTap: (){
                      //             obSurePassword.value = !obSurePassword.value;
                      //           },
                      //           child: Icon(obSure ? Icons.visibility_off : Icons.visibility)
                      //       ),
                      //       hintStyle: TextStyle(color: AppColor.secondaryColors.withOpacity(0.5)),
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //       )
                      //   ),
                      // );
                    },
                  ),

                  const SizedBox(height: 20,),

                  RoundButton(
                      title: 'Login',
                      loading: provider.isLoading,
                      onPress: provider.isLoading ? null : ()=> provider.fetchLoginData(context),
                  ),

                  const SizedBox(height: 10,),

                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, RouteName.register);
                    },
                    child: RichText(
                        text: const TextSpan(
                            text: "Don't have account?",style: TextStyle(color: AppColor.secondaryColors),
                            children: [
                              TextSpan(
                                  text: '  Register', style: TextStyle(color: AppColor.tertiaryColors, fontWeight: FontWeight.bold)
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
