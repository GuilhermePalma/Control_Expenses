import 'package:flutter/material.dart';

class ChartItem extends StatelessWidget {
  final double value;
  final String day;
  final double percentage;
  final bool isCircle;

  const ChartItem({Key? key,
    required this.value,
    required this.day,
    required this.percentage,
    required this.isCircle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SizedBox para deixar um Tamanho FIxo para o Texto de Tamanho Dinamico
        SizedBox(
          height: 15,
          child: FittedBox(
            child: Text("R\$${value.toStringAsFixed(0)}"),
          ),
        ),
        isCircle
            ? CircleAvatar(
                radius: 12,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      // Define o Formato e Background da Barra
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: percentage == 0.0 ? Colors.grey : Colors.green,
                        ),
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    FractionallySizedBox(
                      heightFactor: percentage,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              )
            : Container(
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
                          color: percentage == 0.0 ? Colors.grey : Colors.green,
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

        SizedBox(
          height: 15,
          child: FittedBox(
            child: Text(
              day,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
