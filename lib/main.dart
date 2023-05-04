import 'package:expenses/components/chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../models/transaction.dart';
import 'components/transaction_form.dart';
import 'components/transaction_list.dart';



main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return MaterialApp(
      home: const MyHomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.green,
          secondary: Colors.purple,
        ),
        textTheme: tema.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          labelLarge: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

   final List<Transaction> _transactions = [
      // Transaction(
      //   id: 't0',
      //   title: 'Novo Tênis de Corrida',
      //   value: 310.70,
      //   date: DateTime.now().subtract(const Duration(days: 33))
      // ),
      // Transaction(
      //   id: 't1',
      //   title: 'Novo Tênis de Corrida',
      //   value: 310.70,
      //   date: DateTime.now().subtract(const Duration(days: 3))
      // ),
      // Transaction(
      //   id: 't2',
      //   title: 'Conta de luz',
      //   value: 240.70,
      //   date: DateTime.now().subtract(const Duration(days: 4))
      // ),
    ];

    List<Transaction> get _recentTransactions {
      return _transactions.where((tr) {
        return tr.date!.isAfter(DateTime.now().subtract(
          const Duration(days: 7),
        ));
      }).toList();
    }

    
    _addTransaction(String title, double value, DateTime date) {
      final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date
      );

      setState(() {
        _transactions.add(newTransaction);
      });
      Navigator.of(context).pop();
    }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) {
          return tr.id == id;
      });
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context, 
      builder: (_) {
        return TransactionForm(_addTransaction);
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Expenses"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              color: Colors.white,
              onPressed: () => _openTransactionFormModal(context),
            )
          ] ,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Chart(_recentTransactions),
              TransactionList(_transactions, _deleteTransaction),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          onPressed: () => _openTransactionFormModal(context),
          child: const Icon(Icons.add),
      ),
    );
  }
}
