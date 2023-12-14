import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense/expense.dart';
import 'package:expense_tracker/model/expense/expense_list.dart';
import 'package:expense_tracker/model/expense/form_to_user/cardaddexpense.dart';
import 'package:expense_tracker/model/chart/chart.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // void _incrementCounter() {
  //   setState(() {});
  // }
  final List<Expense> _registExpens = [
    Expense(
      title: 'Pizza',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Full Stack Developer ',
      amount: 30.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'USA',
      amount: 15.99,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];

  void _openAddExpense() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => AddExpense(_addexpense),
    );
  }

  void _addexpense(Expense expense) {
    setState(() {
      _registExpens.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final indexofexpens = _registExpens.indexOf(expense);
    setState(() {
      _registExpens.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: Text('${expense.title} was deleted'),
        action: SnackBarAction(
          label: 'undo',
          onPressed: () {
            setState(() {
              _registExpens.insert(indexofexpens, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContant = const Center(
      child: Text('no expense found .Start add some...'),
    );
    setState(() {
      if (_registExpens.isNotEmpty) {
        mainContant = ExpensesList(
            listOfExpenses: _registExpens, removexpens: _removeExpense);
      }
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: _openAddExpense, icon: const Icon(Icons.add))
        ],
      ),
      body: width < 600
          ? Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Chart(expenses: _registExpens),
                Expanded(
                  child: mainContant,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registExpens)),
                Expanded(
                  child: mainContant,
                ),
              ],
            ),
    );
  }
}
