import 'package:control_expenses/components/chart.dart';
import 'package:control_expenses/components/chart_caption.dart';
import 'package:control_expenses/data/dummy_data.dart';
import 'package:control_expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

// TODO: Obter lista de Transação com as Transações Atualizadas
class _ChartScreenState extends State<ChartScreen> {
  /// Variavel que armazenará as Transações do Usuario
  final List<Transaction> transactionList = dummyTransactions;

  /// Armazena a Quantidade dos "Ultimos Dias" exibidos no Chart.
  int _quantityDays = 7;

  /// Armazena o Valor da quantidade dos "Utlimos Dias" Disponivel
  final List<int> lastDays = [7, 10, 14, 35, 91];

  // Variavel que Controla o Estade de "Ver" ou não a Legenda do Grafico
  bool _showCaptionChart = false;

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
    return SingleChildScrollView(
      child: Column(
        children: [
          Chart(
            listTransactions: lastWeekTransactions(_quantityDays),
            quantityDays: _quantityDays,
            changeWindow: _changeWindow,
          ),
          TextButton(
            onPressed: () {
              setState(() => _showCaptionChart = !_showCaptionChart);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(_showCaptionChart
                    ? Icons.visibility_off_rounded
                    : Icons.manage_search_outlined),
                Text("${_showCaptionChart ? 'Esconder' : 'Ver'} Legenda"),
              ],
            ),
          ),
          if (_showCaptionChart) const ChartCaption(),
        ],
      ),
    );
  }
}
