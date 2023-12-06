import 'package:expense/extensions/date_extensions.dart';
import 'package:expense/extensions/number_extensions.dart';
import 'package:expense/models/expense.dart';
import 'package:flutter/cupertino.dart';

import 'category_badge.dart';



class ExpenseRow extends StatelessWidget {
  final Expense expense;

  const ExpenseRow({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(expense.note!,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                )),
            Text('INR ${expense.amount.removeDecimalZeroFormat()}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                )),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CategoryBadge(category: expense.category!),
              Text(expense.date.time,
                  style: const TextStyle(
                    color: CupertinoColors.inactiveGray,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}