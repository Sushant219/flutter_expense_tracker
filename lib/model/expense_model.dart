import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';


const uuid = Uuid(); // We are making it static so everyone can accesss.earlier it was final but it shows error
enum Category{food,leisure,travel,work}

final formatter = DateFormat.yMd();

const categoryIcon = {
  Category.food : Icons.lunch_dining,
  Category.leisure:Icons.movie_creation_rounded,
  Category.travel:Icons.flight_takeoff_rounded,
  Category.work:Icons.construction,
};

class ExpenseModel{


  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;


  ExpenseModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4(); // Most common → v4 (Random-based)
  // Safe, simple, unique enough for 99% of apps.
  // Best for Firestore or SQLite IDs.
  // If you’re not sure → use uuid.v4().
  // this technique also called Initializer List.


  String get formatingDate{
    return formatter.format(date);
  }
}


class ExpenseBucket{
  ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<ExpenseModel> allExpenses,this.category) :
        expenses = allExpenses
            .where((expense)=>expense.category == category).toList();



  final Category category;
  final List<ExpenseModel> expenses;


  double get totalExpenses{
    double sum = 0;
    for(final expense in expenses){
      sum += expense.amount;
    }
    return sum;
  }

}