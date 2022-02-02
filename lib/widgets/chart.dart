import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/transaction.dart';
import 'package:flutter_application_1/widgets/chart_bar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart(this.recentTransaction, {Key? key}) : super(key: key);
  final List<Transaction> recentTransaction;
  List<Map<String, Object>> get groupedTranasactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalSum += recentTransaction[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  double get totalSpanding {
    return groupedTranasactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTranasactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                (data['day'].toString()),
                (data['amount'] as double),
                totalSpanding == 0.0 ? 0.0 :(data['amount'] as double) / totalSpanding,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
