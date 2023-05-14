import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final Function (DateTime)? onDateChanged;

  const AdaptativeDatePicker({
    this.selectedDate, 
    this.onDateChanged,
    super.key
    });

  _showDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      onDateChanged!(pickedDate);
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Container(
          height: 180,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            minimumDate: DateTime(2019),
            maximumDate: DateTime.now(),
            onDateTimeChanged: onDateChanged!,
          ),
        )
        : SizedBox(
            height: 70,
            child: Row(
              children: <Widget>[
                Text(selectedDate == null
                    ? 'Nenhuma data selecionada!'
                    : 'Data Selecionada ${DateFormat('dd/MM/y').format(selectedDate as DateTime)}'),
                TextButton(
                  onPressed: () => _showDatePicker(context),
                  child: const Text('Selecionar Data'),
                )
              ],
            ),
          );
  }
}