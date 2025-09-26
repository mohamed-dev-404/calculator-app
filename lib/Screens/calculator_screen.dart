import 'package:calculator/Constant/app_colors.dart';
import 'package:calculator/Helper/helper_functions.dart';
import 'package:calculator/Widgets/button_content.dart';
import 'package:calculator/Widgets/calculator_button.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String screenValue =
      ""; // consider as text fild to take the input & RHS in operations
  String lHS = ""; // consider Saved number in cache  & LHS in operations
  String cachOperator = ""; // consider the save operator in cahce
  String?
      tempScreen; // consider the screen value that will be shown but cannot modified by user
  bool operatorLastClicked = false;
  bool equalLastClicked = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.blackBackground,
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  width: double.infinity,
                  child: Text(
                    tempScreen == null ? screenValue : tempScreen!,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CalculatorButton(
                                  onClick: onClearAllClick,
                                  backgroundColor: AppColors.gray,
                                  buttonContent: ButtonContent(
                                    text: 'Ac',
                                    fontSize: 19,
                                    contentColor: AppColors.lightGray,
                                  ),
                                ),
                                CalculatorButton(
                                  onClick: onBackspaceClick,
                                  backgroundColor: AppColors.gray,
                                  buttonContent: ButtonContent(
                                    isIcon: true,
                                    iconPath: 'Assets/images/backspace.png',
                                  ),
                                ),
                                CalculatorButton(
                                  onClick: onOperatorClick,
                                  backgroundColor: AppColors.darkBlue,
                                  buttonContent: ButtonContent(
                                    text: '/',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 6),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CalculatorButton(
                                  onClick: onNumClick,
                                  buttonContent: ButtonContent(
                                    text: '7',
                                  ),
                                ),
                                CalculatorButton(
                                  onClick: onNumClick,
                                  buttonContent: ButtonContent(
                                    text: '8',
                                  ),
                                ),
                                CalculatorButton(
                                  onClick: onNumClick,
                                  buttonContent: ButtonContent(
                                    text: '9',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CalculatorButton(
                                  onClick: onNumClick,
                                  buttonContent: ButtonContent(
                                    text: '4',
                                  ),
                                ),
                                CalculatorButton(
                                  onClick: onNumClick,
                                  buttonContent: ButtonContent(
                                    text: '5',
                                  ),
                                ),
                                CalculatorButton(
                                  onClick: onNumClick,
                                  buttonContent: ButtonContent(
                                    text: '6',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CalculatorButton(
                                  onClick: onNumClick,
                                  buttonContent: ButtonContent(
                                    text: '1',
                                  ),
                                ),
                                CalculatorButton(
                                  onClick: onNumClick,
                                  buttonContent: ButtonContent(
                                    text: '2',
                                  ),
                                ),
                                CalculatorButton(
                                  onClick: onNumClick,
                                  buttonContent: ButtonContent(
                                    text: '3',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CalculatorButton(
                                  onClick: onNumClick,
                                  flex: 2,
                                  buttonContent: ButtonContent(
                                    text: '0',
                                  ),
                                ),
                                CalculatorButton(
                                  onClick: onNumClick,
                                  buttonContent: ButtonContent(
                                    text: '.',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CalculatorButton(
                            onClick: onOperatorClick,
                            flex: 3,
                            backgroundColor: AppColors.darkBlue,
                            buttonContent: ButtonContent(
                              text: '*',
                            ),
                          ),
                          CalculatorButton(
                            onClick: onOperatorClick,
                            flex: 3,
                            backgroundColor: AppColors.darkBlue,
                            buttonContent: ButtonContent(
                              text: '-',
                            ),
                          ),
                          CalculatorButton(
                            onClick: onOperatorClick,
                            flex: 4,
                            backgroundColor: AppColors.darkBlue,
                            buttonContent: ButtonContent(
                              text: '+',
                            ),
                          ),
                          CalculatorButton(
                            onClick: onEqualClick,
                            flex: 5,
                            backgroundColor: AppColors.secondLightBlue,
                            buttonContent: ButtonContent(
                              text: '=',
                              contentColor: AppColors.samawi,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


//! LOGIC SECTION :

  void onNumClick(String num) {
    if (num == '.' && screenValue.contains('.')) {
      return;
    }
    if (operatorLastClicked || equalLastClicked) {
      operatorLastClicked = false;
      equalLastClicked = false;
    }

    tempScreen = null;
    screenValue += num;
    setState(() {});
  }

  void onOperatorClick(String operator) async {
    //if last click is equal then make the screen value equal to the result of the last operation(tempScreen)
    if (equalLastClicked) {
      screenValue = tempScreen!;
      tempScreen = null; //for refresh digit
      equalLastClicked = false;
    }

    if (screenValue.isEmpty || operatorLastClicked) {
      return;
    }

    if (cachOperator.isEmpty) {
      lHS = screenValue;
    } else {
      lHS = opration(lHS, cachOperator, screenValue);
    }

    operatorLastClicked = true;
    cachOperator = operator;
    screenValue = '';

    setState(() {});
    await Future.delayed(
      Duration(milliseconds: 100),
    ); //for refresh the digit (indicate to the user that the operator is clicked)

    tempScreen = lHS;
    setState(() {});
  }

  void onEqualClick(String _) {
    if (screenValue.isEmpty ||
        cachOperator.isEmpty ||
        operatorLastClicked ||
        equalLastClicked) {
      return;
    }

    lHS = opration(lHS, cachOperator, screenValue);
    tempScreen = lHS;
    screenValue = '';
    cachOperator = '';
    lHS = '';
    operatorLastClicked = false;
    equalLastClicked = true;
    setState(() {});
  }

  void onClearAllClick(String _) {
    screenValue = '';
    tempScreen = null;
    operatorLastClicked = false;
    equalLastClicked = false;
    cachOperator = '';
    lHS = '';
    setState(() {});
  }

  void onBackspaceClick(String _) {
    if (screenValue.isEmpty || operatorLastClicked || equalLastClicked) {
      return;
    }
    int lenth = screenValue.length;
    screenValue = screenValue.substring(0, lenth - 1);
    setState(() {});
  }
}
