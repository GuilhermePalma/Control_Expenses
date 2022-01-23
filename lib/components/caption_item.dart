import 'package:flutter/material.dart';

/// Classe Responsavel pelo Layout dos Itens da Legenda do Grafico
class CaptionItem extends StatelessWidget {
  final double percentageFill;
  final Color colorBorder;
  final String text;

  const CaptionItem({
    Key? key,
    required this.text,
    required this.colorBorder,
    required this.percentageFill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.all(
                        color: colorBorder,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: percentageFill,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
