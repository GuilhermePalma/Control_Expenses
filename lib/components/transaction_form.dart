import 'dart:io';

import 'package:control_expenses/components/adaptatives/adaptative_button.dart';
import 'package:control_expenses/components/adaptatives/adaptative_date_picker.dart';
import 'package:control_expenses/components/adaptatives/adaptative_text_field.dart';
import 'package:control_expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(Transaction) onSubmit;
  final void Function() onCancel;

  const TransactionForm({
    Key? key,
    required this.onSubmit,
    required this.onCancel,
  }) : super(key: key);

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
                  AdaptativeTextField(
                    controller: _titleController,
                    textLabel: "Titulo",
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) {},
                  ),
                  AdaptativeTextField(
                    textInputType:
                        const TextInputType.numberWithOptions(decimal: true),
                    // Abre a Proxima Parte do Cadastro (Data)
                    onSubmitted: (_) => Platform.isIOS ? {} : datePicker(),
                    controller: _valueController,
                    textLabel: "Preço (R\$)",
                  ),
                  datePicker()
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
                  AdaptativeButton(
                      text: "Cadastrar Transação", onPressed: _submitForm),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget datePicker() {
    return AdaptativeDatePicker(
      dateSelected: _dateSelected,
      onDateChanged: (newDate) => setState(() => _dateSelected = newDate),
    );
  }
}
