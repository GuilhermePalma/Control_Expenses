import 'package:control_expenses/components/chart_caption.dart';
import 'package:control_expenses/components/transaction_form.dart';
import 'package:control_expenses/components/transaction_list.dart';
import 'package:control_expenses/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'components/chart.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  /// Cria a Parte Principal do APP (Theme) e chama a classe que exibe o Home
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      theme: ThemeData(
        /// Define Estilo Utilizado no APP
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

/// Classe que irá Gerenciar a parte do Home do APP. Nele acontece mudanças de Estado
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Variavel que armazenará as Transações do Usuario
  final List<Transaction> transactionList = [
    Transaction(
      value: 300.0,
      id: Transaction.getIdNow() + "1",
      title: "Conta de Luz",
      date: DateTime.now(),
    ),
    Transaction(
      value: 23.83,
      id: Transaction.getIdNow() + "2",
      title: "Supermercado",
      date: DateTime.now(),
    ),
    Transaction(
      value: 125.65,
      id: Transaction.getIdNow() + "3",
      title: "Conta de Agua",
      date: DateTime.now(),
    ),
    Transaction(
        value: 125.65,
        id: Transaction.getIdNow() + "4",
        title: "Conta de Agua",
        date: DateTime.now().add(const Duration(days: 1))),
    Transaction(
        value: 300.0,
        id: Transaction.getIdNow() + "5",
        title: "Conta de Luz1",
        date: DateTime.now().subtract(const Duration(days: 7))),
    Transaction(
        value: 23.83,
        id: Transaction.getIdNow() + "6",
        title: "Supermercado1",
        date: DateTime.now().subtract(const Duration(days: 8))),
    Transaction(
      value: 125.65,
      id: Transaction.getIdNow() + "7",
      title: "Conta de Agua1",
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  /// Armazena a Quantidade dos "Ultimos Dias" exibidos no Chart.
  int _quantityDays = 7;

  /// Armazena o Valor da quantidade dos "Utlimos Dias" Disponivel
  final List<int> lastDays = [7, 10, 14, 35, 91];

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
  _closeTransactionForm() {
    Navigator.of(context).pop();
  }

  /// Adiciona uma Nova Transação à Lista de Transações
  _addTransaction(Transaction newTransaction) {
    // Atualiza o Estado da Lista exibida no APP
    setState(() => transactionList.add(newTransaction));

    // Fecha o Modal Aberto
    _closeTransactionForm();
  }

  /// Exclui uma Transação da Lista
  _deleteTransaction(String idTransaction) {
    // Atualiza o Estado da Lista exibida no APP, excluindo o Elemento
    setState(() {
      transactionList.removeWhere((element) => element.id == idTransaction);
    });
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

  /// Retorna o IconButton Adaptado para o IOS e Android
  Widget _getButtonNavigation(IconData icon, Function() fn) {
    return Platform.isIOS
        ? GestureDetector(
            onTap: fn,
            child: Icon(icon),
          )
        : IconButton(
            onPressed: fn,
            icon: Icon(icon),
          );
  }

  /// Retorma o Layout exibido no Body do APP
  Widget _bodyWidget(double sizeAppBar) {
    // Objeto MediaQuery para evitar chamadas redundantes
    final mediaQuery = MediaQuery.of(context);

    // Obtem o Tamanho Disponivel para a List Ocupar
    final disponableHeight =
        mediaQuery.size.height - sizeAppBar - mediaQuery.padding.top;

    // Altura Customizada da Exibição da Lista
    final heigthList = mediaQuery.orientation == Orientation.portrait
        ? 0.856 * disponableHeight
        : 0.7 * disponableHeight;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: ToggleButtons(
                color: Colors.black.withOpacity(0.60),
                borderRadius: BorderRadius.circular(4.0),
                isSelected: isSelectedButton,
                onPressed: (index) {
                  setState(() {
                    // Remove a Legenda (O Usuario sempre terá que clicar p/ acessar)
                    showCaptionChart = false;

                    // Tira a Seleção dos Itens Selecionados
                    if (isSelectedButton.contains(true)) {
                      int indexItem = isSelectedButton.indexOf(true);
                      isSelectedButton[indexItem] = false;
                    }

                    // Seleciona o Item que foi Clicado
                    isSelectedButton[index] = true;
                  });
                },
                children: const [
                  Icon(Icons.list_sharp),
                  Icon(Icons.bar_chart_rounded),
                ],
              ),
            ),
            // Obtem a Primeira Posição (Exibir Lista)
            isSelectedButton.elementAt(0)
                ? SizedBox(
                    height: heigthList,
                    child: TransactionList(
                      transactiontions: transactionList,
                      onDelete: _deleteTransaction,
                    ),
                  )
                : Chart(
                    listTransactions: lastWeekTransactions(_quantityDays),
                    quantityDays: _quantityDays,
                    changeWindow: _changeWindow,
                  ),

            if (isSelectedButton.elementAt(1))
              TextButton(
                onPressed: () {
                  setState(() => showCaptionChart = !showCaptionChart);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(showCaptionChart
                        ? Icons.visibility_off_rounded
                        : Icons.manage_search_outlined),
                    Text("${showCaptionChart ? 'Esconder' : 'Ver'} Legenda"),
                  ],
                ),
              ),

            if (isSelectedButton.elementAt(1) && showCaptionChart)
              const ChartCaption(),
          ],
        ),
      ),
    );
  }

  // List que controla a Seleção dos Toggle Buttons
  final List<bool> isSelectedButton = <bool>[true, false];

  // Variavel que Controla o Estade de "Ver" ou não a Legenda do Grafico
  bool showCaptionChart = false;

  @override
  Widget build(BuildContext context) {
    // Organiza a Lista de Transações pelas Datas de forma Decrescente
    transactionList.sort((a, b) => b.date.compareTo(a.date));

    // Itens da App Bar
    const Text titleAppBar = Text("Controle de Despesas");
    final actions = [
      _getButtonNavigation(
        Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionForm(context),
      ),
    ];

    final _appBarAndroid = AppBar(
      actions: actions,
      title: titleAppBar,
    );

    final _appBarIOS = CupertinoNavigationBar(
      middle: titleAppBar,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: actions,
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: _appBarIOS,
            child: _bodyWidget(_appBarIOS.preferredSize.height),
          )
        : Scaffold(
            appBar: _appBarAndroid,
            body: _bodyWidget(_appBarAndroid.preferredSize.height),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _openTransactionForm(context),
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
