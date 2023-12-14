import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:expense_tracker/model/expense/expense.dart';

class AddExpense extends StatefulWidget {
  const AddExpense(this.onAddExpesns, {super.key});

  final Function(Expense expense) onAddExpesns;
  @override
  State<AddExpense> createState() => _AddExpense();
}

class _AddExpense extends State<AddExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedcategory = Category.leisure;
  DateTime? _selectDate;
  void _presrntDatePicker() async {
    final nowDate = DateTime.now();
    final firsDate = DateTime(nowDate.year - 1, nowDate.month, nowDate.day);
    final lastDate = DateTime(nowDate.year + 1, nowDate.month, nowDate.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: nowDate,
      firstDate: firsDate,
      lastDate: lastDate,
    );
    setState(() {
      _selectDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Invalid input '),
          content: const Text(
              'please make sure a valid title, amount , data and category was entered'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('okey'))
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid input '),
          content: const Text(
              'please make sure a valid title, amount , data and category was entered'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('okey'))
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    final enterAmount = double.tryParse(_amountController.text);
    final amuntIsInvalid = enterAmount == null || enterAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amuntIsInvalid ||
        _selectDate == null) {
      _showDialog();
      return;
    }
    widget.onAddExpesns(
      Expense(
        title: _titleController.text,
        amount: enterAmount,
        date: _selectDate!,
        category: _selectedcategory,
      ),
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: Text('${_titleController.text} is add'),
    ));

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final keyboard = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (context, constraints) {
      final maxwidth = constraints.maxWidth;
      return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 50, 16, keyboard + 16),
            child: Column(
              children: [
                if (maxwidth >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          maxLength: 50,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1, //<-- SEE HERE
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            label: const Text('Titel '),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixText: '\$ ',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1, //<-- SEE HERE
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            label: const Text('Amount'),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1, //<-- SEE HERE
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      label: const Text('Titel '),
                    ),
                  ),
                const SizedBox(
                  height: 29,
                ),
                if (maxwidth >= 600)
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButton(
                            value: _selectedcategory,
                            items: Category.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name.toUpperCase()),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              setState(() {
                                _selectedcategory = value;
                              });
                            }),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectDate == null
                                  ? 'no date selcted'
                                  : formater.format(_selectDate!),
                            ),
                            IconButton(
                              onPressed: _presrntDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixText: '\$ ',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1, //<-- SEE HERE
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            label: const Text('Amount'),
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   width: 1,
                      // ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectDate == null
                                  ? 'no date selcted'
                                  : formater.format(_selectDate!),
                            ),
                            IconButton(
                              onPressed: _presrntDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                const SizedBox(
                  height: 25,
                ),
                if (maxwidth >= 600)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('close'),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('save data'),
                      )
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedcategory,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase()),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedcategory = value;
                            });
                          }),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('close'),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('save data'),
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
