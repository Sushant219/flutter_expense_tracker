import 'package:expense_tracker_app/model/expense_model.dart';
import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  const ListCard({super.key, required this.expenses});

  final ExpenseModel expenses ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        //color: Theme.of(context).cardTheme.color,
        child: ListTile(
            title: Text(expenses.title,style:Theme.of(context).textTheme.titleMedium,),
            subtitle:Column(
              crossAxisAlignment: CrossAxisAlignment.start, // align left
              mainAxisSize: MainAxisSize.min, // 👈 shrink to fit
              children: [
                //Text(expense.category.toString()),
                SizedBox(height: 4),
                Text("${expenses.amount}",
                  style:Theme.of(context).textTheme.titleMedium,
                ) ,
              ],
            ),
            trailing:Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(categoryIcon[expenses.category],color:Theme.of(context).iconTheme.color,),
                SizedBox(width: 3),
                Text(
                  expenses.formatingDate,style:Theme.of(context).textTheme.titleMedium,
                ),
              ],
            )
        ),
      ),
    );
  }
}
