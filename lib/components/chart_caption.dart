import 'package:control_expenses/components/caption_item.dart';
import 'package:flutter/material.dart';

/// Classe Responsavel pelo Layout da Legenda do Grafico
class ChartCaption extends StatelessWidget {
  const ChartCaption({Key? key}) : super(key: key);

  final captionItems = const <CaptionItem>[
    CaptionItem(
        text: "Não Houve Gasto no Dia",
        colorBorder: Colors.grey,
        percentageFill: 0),
    CaptionItem(
        text: "Houve Gasto no Dia",
        colorBorder: Colors.green,
        percentageFill: 0),
    CaptionItem(
        text:
            "Preenchimento conforme o Percentual Gasto naquele dia em comparação com o Periodo",
        colorBorder: Colors.green,
        percentageFill: 0.5),
  ];

  @override
  Widget build(BuildContext context) {
    /// Retorna um Card, com Espaçamento Interno e Externo de 8 e 10, respectivamente
    return Card(
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 5),
              child: Text(
                "Legenda",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            // Exibe os Itens de Legenda da Lista com os Widgets
            ...captionItems
          ],
        ),
      ),
    );
  }
}
