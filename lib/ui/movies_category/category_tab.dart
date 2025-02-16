import 'package:flutter/material.dart';
import 'package:movies/theme/app_colors.dart';

class CategoryTab extends StatelessWidget {
  bool isSelected;
  String categoryName;
  Color? backgroundColor;
  TextStyle? textSelectedStyle;
  TextStyle? textUnSelectedStyle;
  CategoryTab(
      {required this.isSelected,
      required this.categoryName,
      this.backgroundColor,
      required this.textSelectedStyle,
      required this.textUnSelectedStyle});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0),
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.04, vertical: height * 0.005),
      decoration: BoxDecoration(
          color: isSelected ? backgroundColor : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border:
              Border.all(color:AppColors.yellowColor, width: 2)),
      child: Text(
        categoryName,
        style: isSelected ? textSelectedStyle : textUnSelectedStyle,
      ),
    );
  }
}