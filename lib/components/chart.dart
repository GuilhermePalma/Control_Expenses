import 'package:control_expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  Chart(this.listTransactions);

  final List<Transaction> listTransactions;

  // Retorna uma Lista com os Ultimos 7 dias antes da Data Atual com os Valores Gastos
  List<Map<String, Object>> get _groupedTransactions {
    return List.generate(7, (index) {
      // Variavel que gerará os valores dos ultimos 7 dias dinamicamente
      final dayWeek = DateTime.now().subtract(Duration(days: index));

      double sumDay = 0.0;

      // Laço de Repetição para agrupar as Transações do mesmo Dia
      for (var item in listTransactions) {
        bool sameDay = item.date.day == dayWeek.day;
        bool sameMonth = item.date.month == dayWeek.month;
        bool sameYear = item.date.year == dayWeek.year;

        if (sameDay && sameMonth && sameYear) sumDay += item.value;
      }

      // Retorna um Map com o Dia da Semana (Sigla em Ingles) e o Valor do Dia
      // todo: alterar para DateFormat.E().format(dayWeek)[0]
      return {"dayWeek": DateFormat('d').format(dayWeek), "value": sumDay};
    });
  }

  // Retorna o Valor Gasto nos ultimos 7 Dias
  double _totalValueWeek(listTransaction) {
    return listTransaction.fold(
        0.0, (sum, transaction) => sum + transaction["value"]);
  }

  @override
  Widget build(BuildContext context) {
    // Obtem os Valores que serão utilizados (Evita Execução Desnecessaria)
    final groupedTransactions = _groupedTransactions;
    final double totalValueWeek = _totalValueWeek(groupedTransactions);

    // Retorna o Grafico Configurado
    return Card(
      margin: const EdgeInsets.all(20),
      elevation: 6,
      child: Row(
        children: groupedTransactions.reversed.map((item) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 5,
              ),
              child: ChartBar(
                value: (item["value"] as double),
                day: (item["dayWeek"] as String),
                percentage: totalValueWeek == 0
                    ? 0
                    : (item["value"] as double) / totalValueWeek,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
