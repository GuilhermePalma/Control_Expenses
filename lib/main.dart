import 'package:control_expenses/screens/transactions_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  /// Cria a Parte Principal do APP (Theme) e chama a classe que exibe o Home
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        /// Define Estilo Utilizado no APP
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(secondary: Colors.amber),
        fontFamily: "Quicksand",
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              button: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const TransactionsScreen(),
    );
  }
}
