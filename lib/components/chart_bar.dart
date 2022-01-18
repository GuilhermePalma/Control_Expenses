import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double value;
  final String day;
  final double percentage;

  ChartBar({
    required this.value,
    required this.day,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          // SizedBox para deixar um Tamanho FIxo para o Texto de Tamanho Dinamico
          height: 18,
          child: FittedBox(
            child: Text("R\$${value.toStringAsFixed(0)}"),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          height: 80,
          width: 13,
          child: Stack(
            // Stack para desenhar e sobrepor os elementos das Barras
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                // Define o Formato e Background da Barra
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                // Se Sobrepõe no Container mostrando a Porcentagem de Gasto no Dia
                heightFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(day),
      ],
    );
  }
}
