import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //text controllers
  TextEditingController nameController = TextEditingController();
   TextEditingController amountController = TextEditingController();

  void openNewExpenseBox() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('New Expense'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
            children: [
              //user-input => expensename
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Name'),
              ),

              //user-input => expenseamt
              TextField(
                controller: amountController,
                decoration: const InputDecoration(hintText: 'Amount'),
              )
            ],
              ),
              actions:[
              
              //cancel button
              _CancelButton()
              //save button
],
            ));
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

  //cancel button
  Widget _CancelButton(){
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
  }

