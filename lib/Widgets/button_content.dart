import 'package:calculator/Constant/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonContent extends StatelessWidget {
  bool isIcon;
  String text;
  String iconPath;
  Color contentColor;
  double fontSize;

  ButtonContent(
      {super.key,
      this.fontSize = 32,
      this.isIcon = false,
      this.text='',
      this.iconPath='',
      this.contentColor = AppColors.lightBlue});

  @override
  Widget build(BuildContext context) {
    return isIcon
        ? ImageIcon(
            size: 40,
            AssetImage(iconPath),
            color: AppColors.lightGray,
          )
        : Text(
            text,
            style: TextStyle(
              color: contentColor,
              fontSize: fontSize,
            ),
          );
  }
}
