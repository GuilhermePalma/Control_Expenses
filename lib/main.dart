import 'package:control_expenses/components/transaction_user.dart';
import 'package:control_expenses/models/transaction.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Controle de Despesas", textAlign: TextAlign.center),
      ),
      body: MyBody(),
    );
  }
}

class MyBody extends StatelessWidget {
  MyBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.red,
            ),
            child: const Text(
              "Grafico",
              textAlign: TextAlign.center,
            ),
          ),
          const TransactionUser(),
        ],
      ),
    );
  }
}
