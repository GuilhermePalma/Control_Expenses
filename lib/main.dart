import 'package:control_expenses/components/transaction_form.dart';
import 'dart:math';
import 'package:control_expenses/components/transaction_list.dart';
import 'package:control_expenses/models/transaction.dart';
import 'package:flutter/material.dart';

import 'components/chart.dart';

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
              button: const TextStyle(
                color: Colors.white,
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
  /// Variavel que armazenará as Transações do Usuario
  final List<Transaction> transactionList = [
    Transaction(
        value: 300.0, id: 0, title: "Conta de Luz", date: DateTime.now()),
    Transaction(
        value: 23.83, id: 1, title: "Supermercado", date: DateTime.now()),
    Transaction(
        value: 125.65, id: 2, title: "Conta de Agua", date: DateTime.now()),
    Transaction(
        value: 125.65,
        id: 2,
        title: "Conta de Agua",
        date: DateTime.now().add(const Duration(days: 1))),
    Transaction(
        value: 300.0,
        id: 3,
        title: "Conta de Luz1",
        date: DateTime.now().subtract(const Duration(days: 7))),
    Transaction(
        value: 23.83,
        id: 4,
        title: "Supermercado1",
        date: DateTime.now().subtract(const Duration(days: 8))),
    Transaction(
        value: 125.65,
        id: 5,
        title: "Conta de Agua1",
        date: DateTime.now().subtract(const Duration(days: 1))),
  ];

  /// Armazena a Quantidade dos "Ultimos Dias" exibidos no Chart
  int _quantityDays = 7;

  /// Armazena o Valor da quantidade dos "Utlimos Dias" Disponivel
  final List<int> lastDays = [7, 10, 14];

  /// Abre o Form de Cadastro de Transações, no estilo Modal
  _openTransactionForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  /// Adiciona uma Nova Transação à Lista de Transações
  _addTransaction(String titleTransaction, double valueTransaction,
      DateTime dateTransaction) {
    final newTransaction = Transaction(
      id: Random().nextInt(150),
      title: titleTransaction,
      value: valueTransaction,
      date: dateTransaction,
    );

    // Atualiza o Estado da Lista exibida no APP
    setState(() => transactionList.add(newTransaction));

    // Fecha o Modal Aberto
    Navigator.of(context).pop();
  }

  /// Obtem as Transações dentro do Intervalo de Dias. Intervalo a partir da Data Atual
  ///
  /// int quantityDays: Representa quantos dias Estarão no Intervalo
  List<Transaction> lastWeekTransactions(int quantityDays) {
    /// Obtem os Dias da Lista anteriores ao dia atual que satisfação ao Intervalo
    return transactionList.where((element) {
      // Verifica se a Data é depois do Periodo Especificado
      bool isAfterDate = element.date
          .isAfter(DateTime.now().subtract(Duration(days: quantityDays)));

      // Verifica se a Data é antes do dia Atual
      bool isBeforeDate = element.date.isBefore(DateTime.now());
      return isAfterDate && isBeforeDate;
    }).toList();
  }

  /// Metodo Responsavel por Alterar a Quantidade de Dias Exibidos no Chart
  _changeWindow(int quantityDays, bool isNextWindow) {
    int position = isNextWindow
        ? lastDays.indexOf(quantityDays) + 1
        : lastDays.indexOf(quantityDays) - 1;

    if (position >= lastDays.length) {
      // Caso a Posição seja o Ultimo Item da Lista, exibe o Primeiro
      _quantityDays = lastDays.first;
    } else if (position < 0) {
      // Caso a Posição seja o Primeiro Item da Lista e esteja voltando, exibe o Ultimo
      _quantityDays = lastDays.last;
    } else {
      // Soma/Subtrai para a Posição Sucessora/Antecessora
      _quantityDays = lastDays.elementAt(position);
    }

    // Atualiza a Quantidade de Dias Exibido
    setState(() => _quantityDays);
  }

  @override
  Widget build(BuildContext context) {
    // Organiza a Lista de Transações pelas Datas de forma Decrescente
    transactionList.sort((a, b) => b.date.compareTo(a.date));

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
            Chart(
              listTransactions: lastWeekTransactions(_quantityDays),
              quantityDays: _quantityDays,
              changeWindow: _changeWindow,
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
