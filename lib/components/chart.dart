import 'package:control_expenses/components/chart_item.dart';
import 'package:control_expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
    required this.listTransactions,
    required this.quantityDays,
    required this.changeWindow,
  }) : super(key: key);

  final List<Transaction> listTransactions;
  final int quantityDays;
  final void Function(int, bool) changeWindow;

  /// Retorna uma Lista com agrupando as Transações do mesmo Dia
  List<Map<String, Object>> get _groupedTransactions {
    // Gera uma Lista Agrupando as Transações e os seus Dias
    return List.generate(quantityDays, (index) {
      // Obtem o Dia que será agrupado as Transações
      final dayWeek = DateTime.now().subtract(Duration(days: index));

      double sumDay = 0.0;

      // Laço de Repetição para agrupar as Transações do mesmo Dia
      for (var item in listTransactions) {
        bool sameDay = item.date.day == dayWeek.day;
        bool sameMonth = item.date.month == dayWeek.month;
        bool sameYear = item.date.year == dayWeek.year;

        if (sameDay && sameMonth && sameYear) sumDay += item.value;
      }

      // Retorna um Map com o Dia e o valor Gasto nele
      return {"dayWeek": DateFormat('d/MM').format(dayWeek), "value": sumDay};
    });
  }

  /// Retorna o Valor Gasto no periodo Especificado
  double _totalValueWeek(listTransaction) {
    return listTransaction.fold(
        0.0, (sum, transaction) => sum + transaction["value"]);
  }

  /// Retorna o Total de Semanas
  int get _totalWeek {
    if (quantityDays % 7 == 0) {
      return int.parse(((quantityDays / 7)).toStringAsFixed(0));
    } else {
      int weeksComplete = quantityDays - (quantityDays % 7);
      return int.parse(((weeksComplete / 7) + 1).toStringAsFixed(0));
    }
  }

  Widget get _chartConfigured {
    // Obtem os Valores que serão utilizados (Evita Execução Desnecessaria)
    final groupedTransactions = _groupedTransactions;
    final double totalValueWeek = _totalValueWeek(groupedTransactions);

    return quantityDays <= 10
        ? Row(
            children: groupedTransactions.reversed.map((item) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 5,
                  ),
                  child: ChartItem(
                    value: (item["value"] as double),
                    day: (item["dayWeek"] as String),
                    percentage: totalValueWeek == 0
                        ? 0
                        : (item["value"] as double) / totalValueWeek,
                    isCircle: false,
                  ),
                ),
              );
            }).toList(),
          )
        : Column(
            children: List.generate(
              _totalWeek,
              (index) {
                // Variaveis que amrazenam os Valores que serão obtidos da Semana
                int initialValue = index == 0 ? 0 : 7 * (index);
                int finalValue = 7 * (index == 0 ? 1 : index + 1);

                if (finalValue > groupedTransactions.length) {
                  finalValue = groupedTransactions.length;
                }

                /// Retorna uma Linha com os Itens
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: groupedTransactions
                      .getRange(initialValue, finalValue)
                      .toList()
                      .map((item) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 5,
                            ),
                            child: ChartItem(
                              value: (item["value"] as double),
                              day: (item["dayWeek"] as String),
                              percentage: totalValueWeek == 0
                                  ? 0
                                  : (item["value"] as double) / totalValueWeek,
                              isCircle: true,
                            ),
                          ),
                        );
                      })
                      .toList()
                      .reversed
                      .toList(),
                );
              },
            ).reversed.toList(),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      elevation: 6,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => changeWindow(quantityDays, false),
                icon: const Icon(Icons.arrow_back_ios_rounded),
              ),
              Text(
                "Ultimos $quantityDays Dias",
                style: Theme.of(context).textTheme.headline6,
              ),
              IconButton(
                onPressed: () => changeWindow(quantityDays, true),
                icon: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ],
          ),
          _chartConfigured,
        ],
      ),
    );
  }
}
