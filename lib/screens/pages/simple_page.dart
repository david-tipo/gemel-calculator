import 'package:flutter/material.dart';
import '../../app_data.dart';
import '../../app_code/gemel_math.dart';
import '../../widgets/custom_text_input.dart';
import '../../models/icons.dart';
import '../../widgets/results_rect.dart';
import '../../models/input_valid_status.dart';
import '../../app_code/input_check.dart';

class SimplePage extends StatefulWidget {
  @override
  _SimplePageState createState() => _SimplePageState();
}

class _SimplePageState extends State<SimplePage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController monthlyAmountController = TextEditingController();
  final TextEditingController yearsController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  int amountBeforeTaxes;
  int amountAfterTaxes;
  InputValidStatus amountStatus;
  InputValidStatus monthlyAmountStatus;
  InputValidStatus yearsStatus;

  /// The String of amountBeforeTaxes
  String get _getAmountBeforeTaxes {
    if (amountBeforeTaxes != null) return amountBeforeTaxes.toString();
    return '--------';
  }

  /// The string of amountAfterTaxes
  String get _getAmountAfterTaxes {
    if (amountAfterTaxes != null) return amountAfterTaxes.toString();
    return '--------';
  }

  /// Calculates the result and updates the vars based on it
  void _calculateResult() {
    GemelMath gemelFund = GemelMath(
      firstAmount: double.parse(amountController.text),
      monthlyAmount: double.parse(monthlyAmountController.text),
      years: int.parse(yearsController.text),
    );
    // updates the class' vars based on user input
    setState(() {
      amountBeforeTaxes = gemelFund.getTotalBeforeTaxes().round();
      amountAfterTaxes = gemelFund.getTotalAfterTaxes().round();
    });
  }



  /// Sets the results based on user input and scrolls to the bottom to show results.
  ///
  /// If user input is not valid, it sets the input vars' status and that displays error message
  void _press() {
    setState(() {
      amountStatus = InputCheck.checkAmount(amountController.text);
      monthlyAmountStatus = InputCheck.checkMonthlyAmount(monthlyAmountController.text);
      yearsStatus = InputCheck.checkYears(yearsController.text);
    });
    bool validInput = amountStatus == InputValidStatus.ok &&
        monthlyAmountStatus == InputValidStatus.ok &&
        yearsStatus == InputValidStatus.ok;
    if (validInput) {
      // make sure it will only scroll and calculate result if the input is valid
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.easeOut,
      );
      _calculateResult();
    }
  }

  @override
  Widget build(BuildContext context) {
    (amountStatus.errorString);
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        APP_DATA.APPBAR_HEIGHT;
    final double textFieldWidth = width / (360 / 182);
    final double textFieldHeight = height / (570 / 36);
    final double textFieldSpacing = height / (570 / 7);
    final TextStyle textFieldStyle =
        Theme.of(context).primaryTextTheme.subtitle2.copyWith(
              fontSize: width /
                  (360 / Theme.of(context).primaryTextTheme.subtitle2.fontSize),
            );
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          // here to center
          SizedBox(
            height: height / (570 / 30),
          ),
          Text(
            'חישוב מהיר',
            style: Theme.of(context).primaryTextTheme.subtitle1.copyWith(
                  fontSize: width / (360 / Theme.of(context).primaryTextTheme.subtitle1.fontSize),
                ),
          ),
          SizedBox(
            height: height / (570 / 33),
          ),
          CustomTextInput(
            title: 'קרן',
            textStyle: textFieldStyle,
            textFieldWidth: textFieldWidth,
            textFieldHeight: textFieldHeight,
            spacing: textFieldSpacing,
            controller: amountController,
            iconData: MyFlutterApp.shekel,
            errorMessage: amountStatus.errorString,
          ),
          SizedBox(
            height: height / (570 / 33),
          ),
          CustomTextInput(
            title: 'הפקדה חודשית',
            textStyle: textFieldStyle,
            textFieldWidth: textFieldWidth,
            textFieldHeight: textFieldHeight,
            spacing: textFieldSpacing,
            controller: monthlyAmountController,
            iconData: MyFlutterApp.shekel,
            errorMessage: monthlyAmountStatus.errorString,
          ),
          SizedBox(
            height: height / (570 / 33),
          ),
          CustomTextInput(
            title: 'שנים',
            textStyle: textFieldStyle,
            textFieldWidth: textFieldWidth,
            textFieldHeight: textFieldHeight,
            spacing: textFieldSpacing,
            controller: yearsController,
            iconData: MyFlutterApp.clock,
            errorMessage: yearsStatus.errorString,
          ),
          SizedBox(
            height: height / (570 / 33),
          ),
          FlatButton(
            color: Theme.of(context).primaryColor,
            minWidth: width / (360 / 131),
            height: height / (570 / 56),
            onPressed: _press,
            child: Text(
              'חשב',
              style: TextStyle(
                fontFamily: 'SecularOne',
                fontSize: width / (360 / 20),
                letterSpacing: 1.5,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(
            height: height / (570 / 79),
          ),
          Text(
            'סה"כ',
            style: Theme.of(context).primaryTextTheme.subtitle1.copyWith(
                  fontSize: width / (360 / Theme.of(context).primaryTextTheme.subtitle1.fontSize),
                ),
          ),
          SizedBox(
            height: height / (570 / 21),
          ),
          ResultsRect(
            totalBeforeTaxes: _getAmountBeforeTaxes,
            totalAfterTaxes: _getAmountAfterTaxes,
          ),
          SizedBox(height: height / (570 / 20)),
        ],
      ),
    );
  }
}
