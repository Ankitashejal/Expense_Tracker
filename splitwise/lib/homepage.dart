import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart'; 
import 'package:splitwise/Database/expense_database.dart';
import 'package:splitwise/helper/helper_functions.dart';
import 'package:splitwise/models/expense.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // Text controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  void openNewExpenseBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // User-input => expense name
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Name'),
            ),
            // User-input => expense amount
            TextField(
              controller: amountController,
              decoration: const InputDecoration(hintText: 'Amount'),
            ),
          ],
        ),
        actions: [
          // Cancel button
          _CancelButton(),
          // Save button
          _SaveButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: openNewExpenseBox,
        child: const Icon(Icons.add),
      ),
    );
  }

  // Cancel button
  Widget _CancelButton() {
    return MaterialButton(
      onPressed: () {
        // Pop dialog
        Navigator.pop(context);
        // Clear controllers
        nameController.clear();
        amountController.clear();
      },
      child: const Text('Cancel'),
    );
  }

  // Save button
  Widget _SaveButton() {
    return MaterialButton(
      onPressed: () async {
        if (nameController.text.isNotEmpty && amountController.text.isNotEmpty) {
          // Create new expense
          Expense newExpense = Expense(
            name: nameController.text,
            amount: convertStringToDouble(amountController.text),
            date: DateTime.now(),
          );

          // Save to DB
          await context.read<ExpenseDatabase>().createNewExpense(newExpense);

          // Clear controllers
          nameController.clear();
          amountController.clear();

          // Pop dialog
          Navigator.pop(context);
        }
      },
      child: const Text('Save'),
    );
  }
}
