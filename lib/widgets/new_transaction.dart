import 'package:flutter/material.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  const NewTransaction(this.addTx, {Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime _selectDate = DateTime.now();

  void submitData() {
    final enterdTitle = titleController.text;
    final enterdAmount = double.parse(amountController.text);

    if (enterdTitle.isEmpty || enterdAmount <= 0) {
      return;
    }

    widget.addTx(
      enterdTitle,
      enterdAmount,
      _selectDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _selectDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
              SizedBox(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Picked Date : ${DateFormat.yMd().format(_selectDate)}'),
                    TextButton(
                      onPressed: _presentDatePicker,
                      child: const Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              TextButton(
                onPressed: submitData,
                child: const Text('Add Transaction'),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.purple,
                  textStyle: const TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
