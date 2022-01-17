import 'package:control_expenses/components/transaction_form.dart';
import 'dart:math';
import 'package:control_expenses/components/transaction_list.dart';
import 'package:control_expenses/models/transaction.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(secondary: Colors.amber),
        fontFamily: "Quicksand",
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Variavel é Fixa, porem pode ser Incluido e Excluido Itens, mantendo a Referencia da Lista
  final List<Transaction> transactionList = [/*
    Transaction(
        value: 300.0, id: 0, title: "Conta de Luz", date: DateTime.now()),
    Transaction(
        value: 23.83, id: 1, title: "Supermercado", date: DateTime.now()),
    Transaction(
        value: 125.65, id: 2, title: "Conta de Agua", date: DateTime.now()), */
  ];

  // Metodo REsponsavel por Abrir o Form de Cadastro de Transações
  _openTransactionForm(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  // Adiciona uma Nova Transação à Lista de Transações
  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextInt(150),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    // Atualiza o Estado da Lista exibida no APP
    setState(() => transactionList.add(newTransaction));

    // Fecha o Modal Aberto
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () => _openTransactionForm(context),
            icon: const Icon(Icons.add),
          )
        ],
        title: const Text("Controle de Despesas"),
      ),
      body: SingleChildScrollView(
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
            TransactionList(transactionList),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionForm(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
