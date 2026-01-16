import 'package:clean_mvvm_pattern/utils/custom/theme_app_color.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final dynamic loading;
  final VoidCallback? onPress;

  const RoundButton({
    required this.title,
    required this.loading,
     this.onPress,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
         onTap: loading ? null : onPress,
         child: Container(
           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
           margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
           decoration:  BoxDecoration(
             color: AppColor.tertiaryColors,
             border: Border.all(width: 1, color: AppColor.secondaryColors),
             borderRadius: BorderRadius.circular(10)
           ),
           child: loading ? const SizedBox( height: 20, width: 20, child: CircularProgressIndicator(),) : Text(title),
         ),
       );

  }
}

