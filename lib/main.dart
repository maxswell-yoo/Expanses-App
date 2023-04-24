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
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

   final _transactions = [
      Transaction(
        id: 't1',
      title: 'Novo Tênis de Corrida',
      value: 310.70,
      date: DateTime.now()),
      Transaction(
        id: 't2',
      title: 'Conta de luz',
      value: 240.70,
      date: DateTime.now()),
    ];

    
    _addTransaction(String title, double value) {
      final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now()
      );

      setState(() {
        _transactions.add(newTransaction);
      });
    }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context, 
      builder: (_) {
        return TransactionForm((str, str2) {});
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
              color: Colors.white60,
              onPressed: () => _openTransactionFormModal(context),
            )
          ] ,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
                const SizedBox(
                child: Card(
                  elevation: 5,
                  color: Colors.amber,
                  child: Text('Grafico'),
                ),
              ),
              TransactionList(_transactions),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          onPressed: () => _openTransactionFormModal(context),
          child: const Icon(Icons.add),
      ),
    );
  }
}
