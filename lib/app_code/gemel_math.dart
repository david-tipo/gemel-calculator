import 'dart:math';

import 'package:flutter/material.dart';

class GemelMath {
  static const double defaultYield = 4 / 100; //4%
  static const double defaultMgmtFee = 0.8 / 100; // 0.99%
  static const double inflation = 2 / 100; // 2%

  final double firstAmount;
  final double monthlyAmount;
  final double yield;
  final double mgmtFee;
  final int years;

  GemelMath(
      {@required this.firstAmount,
      @required this.monthlyAmount,
      @required this.years,
      this.mgmtFee = defaultMgmtFee,
      this.yield = defaultYield});

  /// Returns and calculates the total before taxes
  double getTotalBeforeTaxes() {
    double monthlyYield = pow((1 + yield), (1 / 12));
    double monthlyMgmtFee = 1 - (pow((1 + mgmtFee), (1 / 12)) - 1);
    int monthsAmount = years * 12;
    double sum = firstAmount;
    for (int i = 0; i < monthsAmount; i++) {
      sum = (sum + monthlyAmount) * monthlyYield * monthlyMgmtFee;
    }
    return sum;
  }

  /// Returns and calculates the inflation lost of firstAmount and all the monthlyAmounts
  double _calculateInflationLoss(){
    final double monthlyLoss = pow((1 - inflation) , (1/12));
    int months = years * 12;
    double sumWithInflation = firstAmount;
    for (int i = 0; i < months; i++){
      // runs on every month. adds monthlyAmount and removes inflation lost
      sumWithInflation = (sumWithInflation + monthlyAmount) * monthlyLoss;
    }
    double sumWithNoInflation = firstAmount + monthlyAmount * months;
    return sumWithNoInflation - sumWithInflation; // AKA inflation lost
  }

  /// Returns and calculates and returns the total after taxes and everything
  double getTotalAfterTaxes() {
    double totalBefore = getTotalBeforeTaxes();
    double inflationLoss = _calculateInflationLoss();
    double grossProfit = totalBefore - (firstAmount + monthlyAmount * years * 12);
    double realProfit = grossProfit - inflationLoss;
    if (realProfit <= 0)
      return totalBefore;
    double realTaxes = realProfit * 0.25;
    return totalBefore - realTaxes;
  }

}
