import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime dateSelected;
  final void Function(DateTime) onDateChanged;

  const AdaptativeDatePicker({
    Key? key,
    required this.dateSelected,
    required this.onDateChanged,
  }) : super(key: key);

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: (365 * 4))),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((value) => onDateChanged(value ?? DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate:
                  DateTime.now().subtract(const Duration(days: (365 * 4))),
              maximumDate: DateTime.now().add(const Duration(days: 365)),
              onDateTimeChanged: onDateChanged,
            ),
          )
        : Container(
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
                      'Data: ${DateFormat("dd MMM y").format(dateSelected)}',
                    ),
                    TextButton(
                      onPressed: () => _showDatePicker(context),
                      child: const Text("Escolher Data"),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
