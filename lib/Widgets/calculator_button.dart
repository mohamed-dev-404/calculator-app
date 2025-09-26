import 'package:calculator/Constant/app_colors.dart';
import 'package:calculator/Widgets/button_content.dart';
import 'package:flutter/material.dart';

typedef OnButtonClick = void Function(String text);

// ignore: must_be_immutable
class CalculatorButton extends StatelessWidget {
  ButtonContent buttonContent;
  OnButtonClick onClick;
  Color backgroundColor;
  int flex;

  CalculatorButton({
    required this.buttonContent,
    required this.onClick,
    this.flex = 1,
    this.backgroundColor = AppColors.darkGray,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, bottom: 16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () {
            onClick(buttonContent.text);
          },
          child: buttonContent,
        ),
      ),
    );
  }
}
