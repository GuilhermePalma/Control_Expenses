import 'package:control_expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactiontions;
  final void Function(String) onDelete;

  TransactionList({required this.transactiontions, required this.onDelete});

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
            },
          );
  }
}
