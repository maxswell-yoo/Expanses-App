import 'package:flutter/material.dart';
import 'package:expenses/models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentsTransactions;

  List<Map<String, Object>> get groupTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for(var i = 0; i < recentsTransactions.length; i++) {
        bool sameDay = recentsTransactions[i].date!.day == weekDay.day;
        bool sameMonth = recentsTransactions[i].date!.month == weekDay.month;
        bool sameYear = recentsTransactions[i].date!.year == weekDay.year;

        if(sameDay && sameMonth && sameYear) {
          totalSum += recentsTransactions[i].value!;
        }
      }

      print(DateFormat.E().format(weekDay)[0]);
      print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    });
  }

  const Chart(this.recentsTransactions, {super.key});

  @override
  Widget build(BuildContext context) {
    groupTransactions;
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Row(
        children: groupTransactions.map((tr) {
          return Text("${tr['day']}: ${tr['value']}");
        }).toList(),
      ),
    );
  }
}
