import 'package:intl/intl.dart';

extension Currency on int {
  String toCurrency() {
    final numberFormat = NumberFormat.currency(locale: "vi_VI");
    return numberFormat.format(this);
  }
}
