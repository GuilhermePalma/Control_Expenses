import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const AdaptativeButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(text),
            onPressed: onPressed,
            color: Theme.of(context).textTheme.button!.color,
            padding: const EdgeInsets.symmetric(horizontal: 20),
          )
        : ElevatedButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(
                color: Theme.of(context).textTheme.button!.color,
              ),
            ),
          );
  }
}
