import 'package:control_expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(Transaction) onSubmit;
  final void Function() onCancel;

  TransactionForm({
    required this.onSubmit,
    required this.onCancel,
  });

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _dateSelected = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (Transaction.isValidInfos(title, value)) {
      widget.onSubmit(Transaction(
        id: Transaction.getIdNow(),
        title: title,
        value: value,
        date: _dateSelected,
      ));
    }
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: (365 * 4))),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((value) {
      _dateSelected = value ?? DateTime.now();
      setState(() => _dateSelected);
      return _dateSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.all(16),
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            10,
            20,
            // Da o Espaçamento de quando o Teclado Ocupa Parte da Tela
            MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Nova Transação",
                style: Theme.of(context).textTheme.headline6?.merge(
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
              ),
              Column(
                children: [
                  TextField(
                    controller: _titleController,
                    // Avança para o Proximo TextField (Valor)
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: "Titulo",
                    ),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    // Abre a Proxima Parte do Cadastro (Data)
                    onSubmitted: (_) => _showDatePicker(),
                    controller: _valueController,
                    decoration: const InputDecoration(
                      labelText: "Preço (R\$)",
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Data da Transação",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Data: ${DateFormat("dd MMM y").format(_dateSelected)}',
                            ),
                            TextButton(
                              onPressed: _showDatePicker,
                              child: const Text("Escolher Data"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: widget.onCancel,
                    style: TextButton.styleFrom(primary: Colors.red),
                    child: const Text("Cancelar"),
                  ),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text(
                      "Cadastrar Transação",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.button!.color,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
