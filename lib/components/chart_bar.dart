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
        FittedBox(
          child: Text("R\$${value.toStringAsFixed(0)}"),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          height: 80,
          width: 13,
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            FractionallySizedBox(
              heightFactor: percentage,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ]),
        ),
        Text(day),
      ],
    );
  }
}
