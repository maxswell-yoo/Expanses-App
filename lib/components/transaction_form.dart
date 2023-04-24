import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final title = TextEditingController();
  final value = TextEditingController();
  final void Function(String, double) onSubmit;
  
  TransactionForm(this.onSubmit, {super.key});

  _submitForm() {
    final titleGet = title.text;
    final valueGet = double.tryParse(value.text) ?? 0.0;

    if(titleGet.isEmpty || valueGet <= 0) {
      return;
    }
    onSubmit(titleGet, valueGet);   
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: _submitForm,
                  style: const ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(Colors.blue)),
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
