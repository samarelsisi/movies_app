import 'package:flutter/material.dart';
import 'package:movies/theme/app_colors.dart';
import 'package:movies/theme/app_image.dart';

import '../../theme/app_style.dart';

class MovieInformatiomItem extends StatelessWidget {
  IconData icon;
  String text;
  MovieInformatiomItem({required this.icon,required this.text,super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin:EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
      decoration: BoxDecoration(
          color:AppColors.greyColor,
          borderRadius: BorderRadius.circular(16)

      ),

      child: Row(
        children: [

          Icon(icon,color: Colors.yellow,size: 35,)
          ,
          const SizedBox(width: 8),
          Text(text,style: AppStyle.bold24WhiteRoboto,)
        ],
      ),
    );
  }
}
