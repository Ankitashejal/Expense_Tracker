import 'package:intl/intl.dart';

// Convert string to double
double convertStringToDouble(String string) {
  double? amount = double.tryParse(string);
  return amount ?? 0;
}

// Format double amount into dollars and cents
String formatAmount(double amount) {
  final format = NumberFormat.currency(locale: "hi_IN", symbol:  "₹", decimalDigits: 2);
  return format.format(amount);
}
