import "package:isar/isar.dart";

//this line is neeeded to generate isar file
//run cmd in terminal dart run build_runner build
part 'expense.g.dart';

@collection
class Expense {
  Id id = Isar.autoIncrement; //0 1 2
  final String name;
  final double amount;
  final DateTime date;

  Expense({
    required this.name, 
    required this.amount, 
    required this.date,
    });

  save() {}
}
