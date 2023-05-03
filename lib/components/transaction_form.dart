import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;
  
  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final title = TextEditingController();

  final value = TextEditingController();

  _submitForm() {
    final titleGet = title.text;
    final valueGet = double.tryParse(value.text) ?? 0.0;

    if(titleGet.isEmpty || valueGet <= 0) {
      return;
    }
    widget.onSubmit(titleGet, valueGet);   
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: title,
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
              controller: value,
              decoration: const InputDecoration(labelText: 'Valor (R\$)'),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  const Text('Nenhuma data selecionada!'),
                  TextButton(
                    child: const Text('Selecionar Data'),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: _submitForm,
                  child: const Text('Nova Transação'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
