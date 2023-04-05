import 'package:intl/intl.dart';

extension Currency on int {
  String toCurrency() {
    final numberFormat = NumberFormat.currency(locale: "vi_VI", symbol: "₫");
    return numberFormat.format(this);
  }
}
