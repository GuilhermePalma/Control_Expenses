import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptativeTextField extends StatelessWidget {
  final TextInputType textInputType;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final void Function(String) onSubmitted;
  final String textLabel;

  const AdaptativeTextField({
    Key? key,
    this.textInputType = TextInputType.text,
    required this.controller,
    required this.onSubmitted,
    this.textInputAction = TextInputAction.done,
    required this.textLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: CupertinoTextField(
              keyboardType: textInputType,
              onSubmitted: onSubmitted,
              controller: controller,
              textInputAction: textInputAction,
              placeholder: textLabel,
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 12,
              ),
            ),
          )
        : TextField(
            keyboardType: textInputType,
            onSubmitted: onSubmitted,
            controller: controller,
            textInputAction: textInputAction,
            decoration: InputDecoration(
              labelText: textLabel,
            ),
          );
  }
}
