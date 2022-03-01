import 'package:control_expenses/components/transaction_list.dart';
import 'package:control_expenses/data/dummy_data.dart';
import 'package:control_expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  final List<Transaction> transactionList = dummyTransactions;

  // TODO: Implementar DB para salvar a Exclusão
  /// Exclui uma Transação da Lista
  _deleteTransaction(String idTransaction) {
    // Atualiza o Estado da Lista exibida no APP, excluindo o Elemento
    setState(() {
      transactionList.removeWhere((element) => element.id == idTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TransactionList(
      transactiontions: transactionList,
      onDelete: _deleteTransaction,
    );
  }
}
