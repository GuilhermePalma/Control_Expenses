import 'dart:math';

import 'package:control_expenses/components/transaction_form.dart';
import 'package:control_expenses/components/transaction_list.dart';
import 'package:control_expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({Key? key}) : super(key: key);

  @override
  _TransactionUserState createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  // A variavel é constante, pois sua referencia não mudara, porem é possivel
  // incluir e excluir itens
  List<Transaction> dataExample = [
    Transaction(
        value: 300.0, id: 0, title: "Conta de Luz", date: DateTime.now()),
    Transaction(
        value: 23.83, id: 1, title: "Supermercado", date: DateTime.now()),
    Transaction(
        value: 125.65, id: 2, title: "Conta de Agua", date: DateTime.now()),
  ];

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
          id: Random().nextInt(150),
          title: title,
          value: value,
          date: DateTime.now(),
        );
    setState(() => dataExample.add(newTransaction));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TransactionList(dataExample),
        TransactionForm(_addTransaction),
      ],
    );
  }
}
