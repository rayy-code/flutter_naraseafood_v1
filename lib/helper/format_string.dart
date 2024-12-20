import 'package:intl/intl.dart';
class FormatString {


  static String toRupiah(nominal)
  {
    int angka = nominal;
    String formattedRupiah = NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(angka);

    return formattedRupiah;
  }
}