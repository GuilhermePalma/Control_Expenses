
import 'package:control_expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.onDelete,
  }) : super(key: key);

  final Transaction transaction;
  final void Function(String p1) onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 8,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
                child: Text(
              'R\$ ${transaction.value.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
              ),
            )),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('d MMM y').format(transaction.date),
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? ElevatedButton.icon(
                onPressed: () => onDelete(transaction.id),
                icon: const Icon(Icons.delete_rounded),
                label: const Text("Excluir"),
              )
            : IconButton(
                icon: const Icon(Icons.delete_rounded),
                color: Colors.red[400],
                onPressed: () => onDelete(transaction.id),
              ),
      ),
    );
  }
}