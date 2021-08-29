import 'package:calculator/widgets/results_rect.dart';
import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';
import '../../app_data.dart';
import '../../widgets/custom_text_input.dart';
import '../../app_code/gemel_math.dart';
import '../../models/icons.dart';
import '../../models/input_valid_status.dart';
import '../../app_code/input_check.dart';

class AdvancedPage extends StatefulWidget {
  @override
  _AdvancedPageState createState() => _AdvancedPageState();
}

class _AdvancedPageState extends State<AdvancedPage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController monthlyAmountController = TextEditingController();
  final TextEditingController yearsController = TextEditingController();
  final TextEditingController yieldController = TextEditingController();
  final TextEditingController mgmtFeeController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  int amountBeforeTaxes;
  int amountAfterTaxes;
  InputValidStatus amountStatus;
  InputValidStatus monthlyAmountStatus;
  InputValidStatus yearsStatus;
  InputValidStatus yieldStatus;
  InputValidStatus mgmtFeeStatus;

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
    double yield = double.parse(yieldController.text);
    double mgmtFee = double.parse(mgmtFeeController.text);
    if (yield != 0) yield = yield / 100;
    if (mgmtFee != 0) mgmtFee = mgmtFee / 100;
    GemelMath gemelFund = GemelMath(
      firstAmount: double.parse(amountController.text),
      monthlyAmount: double.parse(monthlyAmountController.text),
      years: int.parse(yearsController.text),
      yield: yield,
      mgmtFee: mgmtFee,
    );
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
      monthlyAmountStatus =
          InputCheck.checkMonthlyAmount(monthlyAmountController.text);
      yearsStatus = InputCheck.checkYears(yearsController.text);
      yieldStatus = InputCheck.checkYield(yieldController.text);
      mgmtFeeStatus = InputCheck.checkMgmtFee(mgmtFeeController.text);
    });
    bool validInput = amountStatus == InputValidStatus.ok &&
        monthlyAmountStatus == InputValidStatus.ok &&
        yearsStatus == InputValidStatus.ok &&
        yieldStatus == InputValidStatus.ok &&
        mgmtFeeStatus == InputValidStatus.ok;
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
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        APP_DATA.APPBAR_HEIGHT;
    final double textFieldWidth = width / (360 / 135);
    final double textFieldHeight = height / (570 / 26);
    final double textFieldSpacing = height / (570 / 12);
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
          //
          // here to center
          SizedBox(height: height / (570 / 30)),
          Text(
            'חישוב מתקדם',
            style: Theme.of(context)
                .primaryTextTheme
                .subtitle1
                .copyWith(fontSize: width / (360 / Theme.of(context).primaryTextTheme.subtitle1.fontSize)),
          ),
          SizedBox(
            height: height / (570 / 44),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
            ],
          ),
          SizedBox(
            height: height / (570 / 32),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextInput(
                title: 'תשואה',
                textStyle: textFieldStyle,
                textFieldWidth: textFieldWidth,
                textFieldHeight: textFieldHeight,
                spacing: textFieldSpacing,
                controller: yieldController,
                iconData: MyFlutterApp.percent_1,
                errorMessage: yieldStatus.errorString,
              ),
              CustomTextInput(
                title: 'דמי ניהול',
                textStyle: textFieldStyle,
                textFieldWidth: textFieldWidth,
                textFieldHeight: textFieldHeight,
                spacing: textFieldSpacing,
                controller: mgmtFeeController,
                iconData: MyFlutterApp.percent_1,
                errorMessage: mgmtFeeStatus.errorString,
              ),
            ],
          ),
          SizedBox(
            height: height / (570 / 32),
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
            height: height / (570 / 39),
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
          // this part is the edge of page
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
