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

  /// Armazena o valor do Intervalo exibidos no Chart.
  int _quantityDays = 7;

  /// Armazena o Valor de Intervalos de Transações do Grafico
  final List<int> lastDays = [7, 10, 14, 35, 91];

  // Variavel que Controla o Estade de "Ver" ou não a Legenda do Grafico
  bool _showCaptionChart = false;

  /// Obtem as Transações dentro do Intervalo de Dias Informado
  List<Transaction> lastWeekTransactions(int quantityDays) {
    return transactionList.where((element) {
      // Verifica se a Data está no Periodo Determinado
      bool isAfterDate = element.date
          .isAfter(DateTime.now().subtract(Duration(days: quantityDays)));
      bool isBeforeDate = element.date.isBefore(DateTime.now());

      return isAfterDate && isBeforeDate;
    }).toList();
  }

  // Função que controla os dias que serão exibidos no Grafico
  _changeWindow(int actualDay, bool isNextDay) {
    // Obtem o Index do Item e Configura se está avançando ou recuando na Lista
    int actualIndex = isNextDay
        ? lastDays.indexOf(actualDay) + 1
        : lastDays.indexOf(actualDay) - 1;

    // Verifica o Index Passado e Configura qual Item será Exibido
    if (actualIndex >= lastDays.length) {
      setState(() => _quantityDays = lastDays.first);
    } else if (actualIndex < 0) {
      setState(() => _quantityDays = lastDays.last);
    } else {
      setState(() => _quantityDays = lastDays.elementAt(actualIndex));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
