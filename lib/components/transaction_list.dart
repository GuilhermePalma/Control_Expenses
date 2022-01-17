import 'package:control_expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactiontions;

  TransactionList(this.transactiontions);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: transactiontions.isEmpty
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
                final tran = transactiontions[index];
                return Card(
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'R\$ ${tran.value.toStringAsFixed(2)}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tran.title,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            DateFormat('d MMM y').format(tran.date),
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  elevation: 5,
                );
              },
            ),
    );
  }
}
