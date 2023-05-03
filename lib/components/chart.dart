import 'package:expenses/components/chart_bar.dart';
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

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    });
  }

  double get _weekTotalValue {
    return groupTransactions.fold(0.0, (acc, item) {
      return acc + (item['value'] as double); 
    });
  }

  const Chart(this.recentsTransactions, {super.key});

  @override
  Widget build(BuildContext context) {
    groupTransactions;
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(label: tr['day'].toString(),
              value: (tr['value'] as double),
              percentage: (tr['value'] as double) / _weekTotalValue,),
            );
          }).toList(),
        ),
      ),
    );
  }
}
