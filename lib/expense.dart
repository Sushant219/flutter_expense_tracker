import 'package:expense_tracker_app/model/expense_model.dart';
import 'package:expense_tracker_app/newexpense.dart';
import 'package:expense_tracker_app/widgets/expense_list.dart';
import 'package:flutter/material.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {

  void openAddExpenseOverLay(){
    showModalBottomSheet(context: context, builder: (ctx)=>Padding(
      padding: const EdgeInsets.all(8.0),
      child: Newexpense(onAddExpense: addExpense),
    ));
  }

  void addExpense(ExpenseModel expense){
    setState(() {
      registeredExpense.add(expense);
    });
  }

  void removeExpense(ExpenseModel expense){
    final registerIndex = registeredExpense.indexOf(expense);
    setState(() {
      registeredExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      content: const Text('Item Deleted!'),
      action:SnackBarAction(
          label: 'Undo',
          onPressed: (){
            setState(() {
              registeredExpense.insert(registerIndex, expense);
            });
          }) ,
    ));
  }

  final List<ExpenseModel> registeredExpense = [
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: [
          IconButton(onPressed: openAddExpenseOverLay, icon: Icon(Icons.add))
        ],
      ),
      body:Column(
        children: [
          Expanded(child: ExpenseList(expense_of_list:registeredExpense,onRemoveExpense: removeExpense,)),
        ],
      )
    );
  }
}
