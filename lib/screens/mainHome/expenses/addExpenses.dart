import 'dart:developer';

import 'package:dukka_test/models/expense.dart';
import 'package:dukka_test/utils/formValidators.dart';
import 'package:dukka_test/utils/hiveVariables.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

class AddExpenses extends StatefulWidget {
  static String rourte='addExpenses';
  const AddExpenses({ Key? key }) : super(key: key);

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  Expense expense=Expense();
  final _formKey = GlobalKey<FormState>();
  bool loading=false;
  Future<void> createExpense()async{
    try{
      List expenses= await Hive.box(HiveVariables.userExpenses).get(HiveVariables.userExpenses,defaultValue: []);
      DateTime creationTime=DateTime.now();
      expense.creationDate=creationTime;
      expense.id=creationTime.millisecondsSinceEpoch.toString();
    expenses.add(expense.toJson());
    await Hive.box(HiveVariables.userExpenses).put(HiveVariables.userExpenses, expenses);
    Fluttertoast.showToast(
        msg: "Expense created",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }catch(e){
      log('expense creation error',error: e.toString());
      Fluttertoast.showToast(
        msg: "Unable to create expense",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  const Text('Add Expense')),
      body:Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed:loading?null: ()async{
            if(_formKey.currentState?.validate()??false){
              loading=!loading;
              setState(() {
                
              });
              await createExpense();
              loading=!loading;
              setState(() {
                
              });
              
            }
          },
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                                 decoration:  InputDecoration(
                                  enabled: !loading,
                                  hintText: 'Title',
                                ),
                                validator: FormValidators.isNotEmptyField,
                                onChanged: (title){
                                  expense.title=title.trim();
                                },
                               ),
                               TextFormField(
                                 decoration:  InputDecoration(
                                  enabled: !loading,
                                  hintText: 'Amount',
                                ),
                                validator: FormValidators.isNumber,
                                keyboardType: TextInputType.number,
                                onChanged: (amount){
                                  expense.amount=num.tryParse(amount.trim());
                                },
                               ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}