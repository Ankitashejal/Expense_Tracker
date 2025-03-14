import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/homepage.dart';
import 'package:splitwise/Database/expense_database.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  //initialize our database
  await ExpenseDatabase.initialize();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ExpenseDatabase(),
      child: const MyApp(),
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
 Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Homepage(),
    );
  }
}

