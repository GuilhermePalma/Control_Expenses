import 'package:control_expenses/models/transaction.dart';

final List<Transaction> dummyTransactions = [
  Transaction(
    value: 300.0,
    id: Transaction.getIdNow() + "1",
    title: "Conta de Luz",
    date: DateTime.now(),
  ),
  Transaction(
    value: 23.83,
    id: Transaction.getIdNow() + "2",
    title: "Supermercado",
    date: DateTime.now(),
  ),
  Transaction(
    value: 125.65,
    id: Transaction.getIdNow() + "3",
    title: "Conta de Agua",
    date: DateTime.now(),
  ),
  Transaction(
      value: 125.65,
      id: Transaction.getIdNow() + "4",
      title: "Conta de Agua",
      date: DateTime.now().add(const Duration(days: 1))),
  Transaction(
      value: 300.0,
      id: Transaction.getIdNow() + "5",
      title: "Conta de Luz1",
      date: DateTime.now().subtract(const Duration(days: 7))),
  Transaction(
      value: 23.83,
      id: Transaction.getIdNow() + "6",
      title: "Supermercado1",
      date: DateTime.now().subtract(const Duration(days: 8))),
  Transaction(
    value: 125.65,
    id: Transaction.getIdNow() + "7",
    title: "Conta de Agua1",
    date: DateTime.now().subtract(const Duration(days: 1)),
  ),
];
