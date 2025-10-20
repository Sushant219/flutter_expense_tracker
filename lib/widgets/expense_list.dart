import 'package:expense_tracker_app/model/expense_model.dart';
import 'package:expense_tracker_app/widgets/list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.expense_of_list,required this.onRemoveExpense});

  final List<ExpenseModel> expense_of_list;
  final void Function(ExpenseModel expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
          itemCount: expense_of_list.length,
          itemBuilder: (context,index){
        return Dismissible(
            key: ValueKey(expense_of_list[index]),
        onDismissed: (direction){
              onRemoveExpense(expense_of_list[index]);
              print('List Deleted');
        },
        child: ListCard(expenses: expense_of_list[index]));
      },
    );
  }
}
