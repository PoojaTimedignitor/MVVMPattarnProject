import 'dart:developer';

import 'package:clean_mvvm_pattern/view/single_product_view.dart';
import 'package:clean_mvvm_pattern/view/search_product_view.dart';
import 'package:clean_mvvm_pattern/view_model/auth/login_provider.dart';
import 'package:clean_mvvm_pattern/view_model/auth/token_store_provider.dart';
import 'package:flutter/material.dart';
import '../sql_db/UserScreen.dart';
import '../utils/custom/show_dialog.dart';
import '../utils/custom/theme_app_color.dart';
import 'package:provider/provider.dart';
import '../utils/routes/route_name.dart';
import '../view_model/auth/get_storage.dart';
import '../view_model/theme_provider.dart';
import 'create_product_view.dart';
import 'get_product_list.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  List<String> names = ["Get All Product", "View Single Product", "Create Product", "Search Product"];

  final List<Widget> screens = [
    const GetProductList(),
    const SingleProductView(),
    const UserScreen(),
    // const CreateProductView(),
    const SearchProductView(),
  ];
  LogoutClass logoutClass = LogoutClass();

  @override
  void initState() {
    super.initState();
   // logoutClass.showLogoutDialog(context);
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<LoginProvider>(context, listen: false).getMeApiData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.tertiaryColors,
        title: const Text('Home Screen'),
        leading: Consumer<ThemeProvider>(
          builder: (context, value, child) {
            return IconButton(
              icon: Icon(
                  value.isDarkMode
                      ? Icons.dark_mode
                      : Icons.light_mode,
                  size: 25
              ),
              color: value.isDarkMode ? Colors.black : Colors.white,
              onPressed: () {
                value.setTheme();
              },
            );
          },
        ),

        actions:  [
          IconButton(
           // onPressed: logoutClass.showLogoutDialog(context),
            onPressed: () {
              logoutClass.showLogoutDialog(context);
            },
            icon: const Icon(Icons.logout),
          ),
          const SizedBox(width: 10,)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<LoginProvider>(
              builder: (context, provider, child) {
               final id = provider.meModel?.id;
                return Center(
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        children: [
                          Image.network(
                            provider.meModel?.image ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/img.png',
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                          Text("id : $id"),
                          Text('Name : ${provider.meModel?.firstName ?? 'unknown'} ${provider.meModel?.lastName ?? ''}'),
                          Text('Email : ${provider.meModel?.email ?? 'unknown'}'),
                          Text('Age : ${provider.meModel?.age ?? 'unknown'}'),
                          Text('Gender : ${provider.meModel?.gender ?? 'unknown'}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 30,),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3,
                ),
                itemBuilder: (BuildContext context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => screens[index]),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.tertiaryColors,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(names[index], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),),
                      ),
                    );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}




// class LogoutClass {
//    showLogoutDialog(BuildContext context) async {
//     return showDialog(
//         context: context,
//         barrierDismissible: true,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Logout'),
//             content: const Text('Are you sure want to logout ?'),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text('Cancel')),
//               TextButton(
//                   onPressed: () async {
//                     final tokenStore =
//                         Provider.of<TokenStoreProvider>(context, listen: false);
//                     log('Clear Token : $tokenStore');
//                     log('Successful Logout : $tokenStore');
//                     await tokenStore.clearToken();
//                     if (context.mounted) {
//                       Navigator.pushNamedAndRemoveUntil(
//                           context, RouteName.login, (route) => false);
//                     }
//                   },
//                   child: const Text('Yes')),
//             ],
//           );
//         }
//         );
//   }
// }


class LogoutClass {
  void showLogoutDialog(BuildContext context) {
    showCustomDialog(
      context: context,
      title: 'Logout',
      message: 'Are you sure you want to logout?',
      icon: Icons.logout,
      iconColor: Colors.red,
      confirmText: 'Yes',
      cancelText: 'Cancel',
      onConfirm: () async {
        final tokenStore =
        Provider.of<TokenStoreProvider>(context, listen: false);

        log('Clear Token : $tokenStore');
        await tokenStore.clearToken();

        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteName.login,
                (route) => false,
          );
        }
      },
    );
  }
}