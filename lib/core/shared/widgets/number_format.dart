import 'package:intl/intl.dart';

String formatNumber(double number) {
  NumberFormat formatter = NumberFormat("#,###");
  String formatted = formatter.format(number);
  return 'UgShs. $formatted';
}
