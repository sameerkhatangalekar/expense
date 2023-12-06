import 'package:flutter/cupertino.dart';

import '../../models/expense.dart';
import 'day_expenses.dart';



class ExpensesList extends StatelessWidget {
  final Map displayedExpenses;

  const ExpensesList({
    super.key,
    required this.displayedExpenses,
  });
  @override
  Widget build(BuildContext context) {
    return CupertinoScrollbar(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: displayedExpenses.length,
        itemBuilder: (context, index) {
          final DateTime date = displayedExpenses.keys.elementAt(index);
          final List<Expense> dayExpenses = displayedExpenses[date]!;

          if (dayExpenses.isEmpty) {
            return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Text('No expenses for period'));
          }

          return DayExpenses(date: date, expenses: dayExpenses);
        },
      ),
    );
  }
}