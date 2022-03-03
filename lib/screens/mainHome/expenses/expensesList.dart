import 'dart:developer';
import 'package:dukka_test/screens/mainHome/expenses/addExpenses.dart';
import 'package:intl/intl.dart';
import 'package:dukka_test/models/expense.dart';
import 'package:dukka_test/utils/hiveVariables.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ExpensesList extends StatefulWidget {
  static String route='expenses';
  const ExpensesList({ Key? key }) : super(key: key);

  @override
  State<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  Future<List<Expense>> getExpenses()async{
    List expenses=Hive.box(HiveVariables.userExpenses).get(HiveVariables.userExpenses,defaultValue: []);
    log(expenses.toString(),name: 'Expenses');
    List<Expense> expensesList=List.generate(expenses.length, (index) => Expense.fromJson(Map<String,dynamic>.from(expenses[index])));

    return expensesList;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child:const Icon(Icons.add),
        onPressed: ()async{
         await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  const AddExpenses()),
  );
  setState(() {
    
  });
        },
      ),
      body: FutureBuilder<List<Expense>>(
        future: getExpenses(),
        builder: (context,expensesList){
          if(expensesList.hasError){
            log('expenses error',error: expensesList.error);
            return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Unable to check user expenses',style: TextStyle(color: Colors.black),),
                    IconButton(
                      icon: Icon(Icons.replay,color: Theme.of(context).errorColor,),
                      onPressed: (){
                        //The futurebuilder will rebuild automatically
                        setState(() {
                          
                        });
                      },
                    )
                  ],
                );
          }else if(!expensesList.hasData){
            return const Center(child: CircularProgressIndicator(),);
          }else{
            if(expensesList.data!.isEmpty){
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('No Expenses'),
                   IconButton(
                      icon: const Icon(Icons.replay,),
                      onPressed: (){
                        //The futurebuilder will rebuild automatically
                        setState(() {
                          
                        });
                      },
                    )
                  ],
                ),
              );
            }else{
              return ListView.builder(
                itemCount: expensesList.data!.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(expensesList.data![index].title??''),
                                Text('\$'+expensesList.data![index].amount.toString())
                              ],
                            ),
                            Text(DateFormat('yyyy-MM-dd hh:mm').format(expensesList.data![index].creationDate??DateTime.now()))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}