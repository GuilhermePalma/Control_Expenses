class Transaction {
  final int id;
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
}
