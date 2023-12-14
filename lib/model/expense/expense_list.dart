import 'package:expense_tracker/model/expense/expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense/expense_card.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.listOfExpenses, required this.removexpens});
  final List<Expense> listOfExpenses;
  final void Function(Expense expense) removexpens;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listOfExpenses.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9),
        child: Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            margin: const EdgeInsets.symmetric(horizontal: 5),
          ),
          key: ValueKey(listOfExpenses[index]),
          onDismissed: (direction) {
            removexpens(listOfExpenses[index]);
          },
          child: ExpenseCard(expense: listOfExpenses[index]),
        ),
      ),
    );
  }
}
