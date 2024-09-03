import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppUtils {
  static Color hexToColor(String? hex) {
    // Add FF at the beginning for the alpha channel (fully opaque)
    final hexCode = (hex ?? '').replaceAll('#', '');
    final color = Color(int.parse('FF$hexCode', radix: 16));
    return color;
  }

  static const String naira = '\u20A6';
  // static const String naira = '';

  static String generateAmountDigits(
    dynamic amount, {
    String? currency = '\u20A6',
    int? decimalDigits = 2,
  }) {
    double? amountString;

    if (amount is String) {
      amountString = double.parse(amount);
    } else if (amount is int) {
      amountString = amount.toDouble();
    } else if (amount is double) {
      amountString = amount;
    }

    return amountString == null
        ? 'N/A'
        : NumberFormat.simpleCurrency(
            decimalDigits: decimalDigits,
            name: currency?.toUpperCase(),
          ).format(amountString);
  }
}
