import 'package:expense_tracker_app/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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



  void submitExpense() {
    final enteredTitle = _titleController.text.trim();
    final enteredAmount = double.tryParse(_priceController.text);
    final isAmountInvalid = enteredAmount == null || enteredAmount <= 0;

    String? errorMessage;

    // Check each field one by one
    if (enteredTitle.isEmpty) {
      errorMessage = 'Please enter a title for the expense.';
    } else if (isAmountInvalid) {
      errorMessage = 'Please enter a valid amount greater than 0.';
    } else if (selectedDate == null) {
      errorMessage = 'Please select a date.';
    }

    // If any validation fails, show a dialog with the exact reason
    if (errorMessage != null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: Text(errorMessage!),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
     // return; // stop further execution if invalid
    }

    // ✅ Only runs if everything is valid
    widget.onAddExpense(
      ExpenseModel(
        title: enteredTitle,
        amount: enteredAmount!,
        date: selectedDate!,
        category: selectedCategory,
      ),
    );
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
                  icon: Icon(FontAwesomeIcons.calendarDay),
                ),
                Text(selectedDate == null ?'Not Selected':formatter.format(selectedDate!),
                  ),
                SizedBox(width: 30),
                TextButton(
                    onPressed:(){
                      submitExpense();
                      Navigator.pop(context);
                    },
                    child: Text('Save')),
                SizedBox(width: 30),
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
