import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spandingPctofTotal;

  const ChartBar(this.label, this.spendingAmount, this.spandingPctofTotal,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          SizedBox(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          SizedBox(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    color: const Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spandingPctofTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          SizedBox(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text(label),
            ),
          ),
        ],
      );
    });
  }
}
