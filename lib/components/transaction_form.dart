import 'package:control_expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit);

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (Transaction.isValidInfos(title, value)) onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
        child: Column(
          children: [
            TextField(
                // TODO ALTERAR PARA UM METODO QUE ABRA O TEXTFIELD DE PREÇO
                onSubmitted: (_) => _submitForm(),
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Titulo",
                )),
            TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                // É ignorado o valor desse TextField, para usar os valores dos Controllers
                onSubmitted: (_) => _submitForm(),
                controller: valueController,
                decoration: const InputDecoration(
                  labelText: "Preço (R\$)",
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(primary: Colors.red),
                  child: const Text("Cancelar"),
                ),
                TextButton(
                  onPressed: _submitForm,
                  style: TextButton.styleFrom(primary: Colors.purple),
                  child: const Text("Cadastrar Transação"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
