import 'package:control_expenses/components/transaction_item.dart';
import 'package:control_expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactiontions;
  final void Function(String) onDelete;

  const TransactionList(
      {Key? key, required this.transactiontions, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactiontions.isEmpty
        ? Column(
            children: <Widget>[
              Text(
                "Nenhuma Transação Cadastrada",
                style: Theme.of(context).textTheme.headline6,
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                height: 200,
                child: Image.asset(
                  "assets/images/waiting.png",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemCount: transactiontions.length,
            itemBuilder: (contex, index) {
              final transaction = transactiontions[index];
              return TransactionItem(
                transaction: transaction,
                onDelete: onDelete,
              );
            },
          );
  }
}
