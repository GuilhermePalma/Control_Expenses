import 'dart:io';

import 'package:control_expenses/components/transaction_form.dart';
import 'package:control_expenses/models/transaction.dart';
import 'package:control_expenses/screens/chart_screen.dart';
import 'package:control_expenses/screens/transaction_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabsScreen> {
  /// Variavel que armazena os Valores das Tabs Inferiores
  final List<Map<String, Object>> _listScreens = [
    {
      // Parametros da AppBar e Body
      "title": "Lista de Despesas",
      "screen": const TransactionListScreen(),
      // Parametros do Item no Menu Inferior
      "label": "Transações",
      "icon": Icons.list_sharp,
    },
    {
      "title": "Grafico de Gastos",
      "screen": const ChartScreen(),
      "label": "Grafico",
      "icon": Icons.bar_chart_rounded,
    },
  ];

  /// Armazena o Index da Tab Selecionada
  int _indexSelectedScreen = 0;

  /// Configura o Icone "+" na AppBar
  Widget actionAddTransaction(BuildContext context) {
    final IconData icon = Platform.isIOS ? CupertinoIcons.add : Icons.add;
    return Platform.isIOS
        ? GestureDetector(
            onTap: () => _openTransactionForm(context),
            child: Icon(icon),
          )
        : IconButton(
            onPressed: () => _openTransactionForm(context),
            icon: Icon(icon),
          );
  }

  /// Abre o Form de Cadastro de Transações, no estilo Modal
  _openTransactionForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(
          onSubmit: _addTransaction,
          onCancel: _closeTransactionForm,
        );
      },
    );
  }

  /// Fecha o Modal Aberto
  _closeTransactionForm() => Navigator.of(context).pop();

  /// Adiciona uma Nova Transação à Lista de Transações
  // TODO Implementar o Cadastramento de Transações
  _addTransaction(Transaction newTransaction) => _closeTransactionForm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _listScreens.elementAt(_indexSelectedScreen)["title"] as String),
        actions: [
          actionAddTransaction(context),
        ],
      ),
      body: _listScreens.elementAt(_indexSelectedScreen)["screen"] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indexSelectedScreen,
        items: _listScreens.map((tabItem) {
          return BottomNavigationBarItem(
            icon: Icon(tabItem["icon"] as IconData),
            label: tabItem["label"] as String,
          );
        }).toList(),
        onTap: (index) => setState(() => _indexSelectedScreen = index),
      ),
    );
  }
}
