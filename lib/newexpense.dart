import 'package:expense_tracker_app/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


final formatter = DateFormat.yMd();
class Newexpense extends StatefulWidget {
  const Newexpense({super.key, required this.onAddExpense});


  final void Function(ExpenseModel expense) onAddExpense;
  @override
  State<Newexpense> createState() => _NewexpenseState();
}

class _NewexpenseState extends State<Newexpense> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  DateTime? selectedDate;
  Category selectedCategory = Category.food;



  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    super.dispose();
  }
  
  Future<void> _presentDatePicker() async {
    final pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
    );
    setState(() {
      selectedDate = pickedDate;
    });
  }



  void submitExpense(){
    final enteredAmount = double.tryParse(_priceController.text);
    final amountInValid = enteredAmount == null || enteredAmount <=0;
    if (_titleController.text.trim().isEmpty || amountInValid || selectedDate == null){
      showDialog(context: context, builder: (ctx)=>AlertDialog(
        title: Text('Invalid Input'),
        content: const Text('Please make sure to enter valid input'),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(ctx);
          }, child: Text('Okay'))
        ],
      ));
    }
    widget.onAddExpense(ExpenseModel(
        title: _titleController.text,
        amount: enteredAmount !,
        date: selectedDate!,
        category: selectedCategory
    ));
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Text("Title"),
                border: InputBorder.none,          // removes underline
                enabledBorder: InputBorder.none,   // ensures no underline in enabled state
                focusedBorder: InputBorder.none,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text("₹"),
                      border: InputBorder.none,          // removes underline
                      enabledBorder: InputBorder.none,   // ensures no underline in enabled state
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                // DropDown
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: selectedCategory,
                      items:Category.values.map((category)=>DropdownMenuItem(
                    value: category,
                    child:Text(category.name.toUpperCase()),),
                  ).toList(),
                      onChanged:(value){
                        if(value==null){
                          return;
                        }
                        setState(() {
                          selectedCategory = value;
                        });
                        print(value);
                      }),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: _presentDatePicker,
                  icon: Icon(Icons.calendar_month_rounded),
                ),
                Text(selectedDate == null ?'Not Selected':formatter.format(selectedDate!),
                  ),
                SizedBox(width: 38),
                TextButton(
                    onPressed:(){
                      submitExpense();
                      Navigator.pop(context);
                    },
                    child: Text('Save')),
                SizedBox(width: 38),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel')),
              ],
            )
          ],
        ),
    )
    );
  }
}
