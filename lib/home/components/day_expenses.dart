import 'package:expense/extensions/date_extensions.dart';
import 'package:expense/extensions/expense_extensions.dart';
import 'package:expense/extensions/number_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/expense.dart';
import 'expenses_row.dart';

class DayExpenses extends StatelessWidget {
  final DateTime date;
  final List<Expense> expenses;

  const DayExpenses({
    super.key,
    required this.date,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(date.formattedDate,
              style: const TextStyle(
                color: CupertinoColors.inactiveGray,
                fontWeight: FontWeight.w500,
              )),
          const Divider(
            thickness: 2,
            color: CupertinoColors.darkBackgroundGray,
          ),
          ListView.builder(
            itemCount: expenses.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var expense = expenses[index];
              return Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: ExpenseRow(
                    expense: expense,
                  ));
            },
          ),
          const Divider(
            thickness: 2,
            color: CupertinoColors.darkBackgroundGray,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Expanded(
                child: Text(
                  'Total:',
                  style: TextStyle(
                    color: CupertinoColors.inactiveGray,
                  ),
                ),
              ),
              Text(
                'INR ${expenses.sum().removeDecimalZeroFormat()}',
                style: const TextStyle(
                  color: CupertinoColors.inactiveGray,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
