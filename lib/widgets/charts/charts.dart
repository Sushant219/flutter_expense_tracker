import 'package:expense_tracker_app/model/expense_model.dart';
import 'package:expense_tracker_app/ui/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Charts extends StatelessWidget {
  const Charts({super.key, required this.expense});

  final List<ExpenseModel> expense;
  
  List<ExpenseBucket> get buckets{
    return[
      ExpenseBucket.forCategory(expense, Category.food),
      ExpenseBucket.forCategory(expense, Category.work),
      ExpenseBucket.forCategory(expense, Category.travel),
      ExpenseBucket.forCategory(expense, Category.leisure),
    ];
  }
  
  double get maxTotalExpense{
    double maxTotal = 0;
    for(final bucket in buckets){
      if (bucket.totalExpenses > maxTotal){
        maxTotal = bucket.totalExpenses;
      }
    }
    return maxTotal;
  }


  @override
  Widget build(BuildContext context) {
    final isDarkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Card(
        elevation: 4,
        margin:EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta){
                          final category = buckets[value.toInt()].category;
                          return Padding(padding: EdgeInsets.only(top: 6.0),
                            child: Text(
                              category.name.toUpperCase(),
                              style: TextStyle(
                                color: isDarkTheme? AppColors.darkGrey6:AppColors.darkGrey1,
                                fontSize: 12
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: buckets.asMap().entries.map((entry){
                    final index = entry.key;
                    final bucket = entry.value;
                    //final maxBarHeight = 1.0;

                    final barHeight = maxTotalExpense ==0?0.0:(bucket.totalExpenses/maxTotalExpense);
                    return BarChartGroupData(x: index,
                      barRods: [
                        BarChartRodData(
                          toY: barHeight,
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10),
                          width: 20,
                          rodStackItems:[
                            BarChartRodStackItem(0,barHeight,Theme.of(context).colorScheme.primary,),
                            BarChartRodStackItem(barHeight,1,Colors.blueAccent)
                          ]
                        )
                      ]
                    );
                  }).toList(),
                ),
            ),
          ),
        )
      ),
    );
  }
}
