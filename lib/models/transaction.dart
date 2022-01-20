import 'package:intl/intl.dart';

class Transaction {
  final String id;
  final String title;
  final double value;
  final DateTime date;

  Transaction({
    required this.value,
    required this.id,
    required this.title,
    required this.date,
  });

  static bool isValidInfos(String title, double value) {
    return title.isNotEmpty && value > 0;
  }

  static String getIdNow() {
    return DateFormat("DDMMy_H_m_s").format(DateTime.now());
  }
}
