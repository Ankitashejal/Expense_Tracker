import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:splitwise/models/expense.dart';

class ExpenseDatabase extends ChangeNotifier {
  static late Isar isar;
  List<Expense> _allExpenses = [];

  /*
  Setup
  */

  // Initialize the database
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([ExpenseSchema], directory: dir.path);
  }

  /*
  Getters
  */
  List<Expense> get allExpenses => _allExpenses;

  /*
  Operations
  */
  
  // Create a new expense
  Future<void> createNewExpense(Expense newExpense) async {
    // Add to DB
    await isar.writeTxn(() => isar.expenses.put(newExpense));

    // Re-read from DB
    await readExpenses();
  }

  // Read expenses from DB
  Future<void> readExpenses() async {
    // Fetch all existing expenses from DB
    List<Expense> fetchedExpenses = await isar.expenses.where().findAll();

    // Update the local expense list
    _allExpenses.clear();
    _allExpenses.addAll(fetchedExpenses);

    // Update UI
    notifyListeners();
  }

  // Update an expense
  Future<void> updateExpense(int id, Expense updatedExpense) async {
    // Make sure the new expense has the same ID as the existing one
    updatedExpense.id = id;

    // Update in DB
    await isar.writeTxn(() => isar.expenses.put(updatedExpense));

    // Re-read from DB
    await readExpenses();
  }

  // Delete an expense
  Future<void> deleteExpense(int id) async {
    // Delete from DB
    await isar.writeTxn(() => isar.expenses.delete(id));

    // Re-read from DB
    await readExpenses();
  }

  /*
  Helper methods
  */
}
