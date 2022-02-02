import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deletetx;

  const TransactionList(
      {Key? key, required this.transaction, required this.deletetx})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? LayoutBuilder(builder: (ctx, constrains) {
            return Column(
              children: [
                const Text('No transaction added yet!'),
                const SizedBox(
                   height: 20,
                ),
                SizedBox(
                  height: constrains.maxHeight *0.7,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                          child: Text('\$${transaction[index].amount}')),
                    ),
                  ),
                  title: Text(
                    transaction[index].title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle:
                      Text(DateFormat.yMMMd().format(transaction[index].date)),
                  trailing: IconButton(
                    onPressed: () => deletetx(transaction[index].id),
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
              );
            },
            itemCount: transaction.length,
          );
  }
}
