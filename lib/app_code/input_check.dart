import '../models/input_valid_status.dart';

class InputCheck {
  /// Checks if given [string] amount valid.
  /// And returns [InputValidStatus] with the valid status
  static InputValidStatus checkAmount (String amount) {
    if (amount.isEmpty)
      return InputValidStatus.empty;
    try {
      //checks if really is double
      double.parse(amount);
    }
    on Exception{
      return InputValidStatus.invalidChar;
    }
    double doubleAmount = double.parse(amount);
    if (doubleAmount < 0)
      return InputValidStatus.belowZero;
    if (doubleAmount > 1000000) // 1,000,000
      return InputValidStatus.tooBig;
    return InputValidStatus.ok;
  }

  /// Checks if given [string] monthly-amount valid.
  /// And returns [InputValidStatus] with the valid status
  static InputValidStatus checkMonthlyAmount (String monthlyAmount) {
    if (monthlyAmount.isEmpty)
      return InputValidStatus.empty;
    try {
      //checks if really is double
      double.parse(monthlyAmount);
    }
    on Exception{
      return InputValidStatus.invalidChar;
    }
    double doubleMonthlyAmount = double.parse(monthlyAmount);
    if (doubleMonthlyAmount < 0)
      return InputValidStatus.belowZero;
    if (doubleMonthlyAmount > 10000) //10,000
      return InputValidStatus.tooBig;
    return InputValidStatus.ok;
  }

  /// Checks if given [string] yield valid.
  /// And returns [InputValidStatus] with the valid status
  static InputValidStatus checkYield (String yield) {
    if (yield.isEmpty) {
      return InputValidStatus.empty;
    }
    try {
      //checks if really is double
      double.parse(yield);
    }
    on Exception{
      return InputValidStatus.invalidChar;
    }
    double doubleYield = double.parse(yield);
    if (doubleYield < 0)
      return InputValidStatus.belowZero;
    if (doubleYield > 200)
      return InputValidStatus.tooBig;
    return InputValidStatus.ok;
  }

  /// Checks if given [string] mgmtFee valid.
  /// And returns [InputValidStatus] with the valid status
  static InputValidStatus checkMgmtFee (String mgmtFee) {
    if (mgmtFee.isEmpty)
      return InputValidStatus.empty;
    try {
      //checks if really is double
      double.parse(mgmtFee);
    }
    on Exception{
      return InputValidStatus.invalidChar;
    }
    double doubleMgmtFee = double.parse(mgmtFee);
    if (doubleMgmtFee < 0)
      return InputValidStatus.belowZero;
    if (doubleMgmtFee > 5)
      return InputValidStatus.tooBig;
    return InputValidStatus.ok;
  }

  /// Checks if given [string] years valid.
  /// And returns [InputValidStatus] with the valid status
  static InputValidStatus checkYears (String years) {
    if (years.isEmpty)
      return InputValidStatus.empty;
    try {
      //checks if really is int
      int.parse(years);
    }
    on Exception{
      return InputValidStatus.invalidChar;
    }
    int intYears = int.parse(years);
    if (intYears < 0)
      return InputValidStatus.belowZero;
    if (intYears > 100)
      return InputValidStatus.tooBig;
    return InputValidStatus.ok;
  }
}