import 'dart:developer';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:dukka_test/models/debit.dart';
import 'package:dukka_test/utils/formValidators.dart';
import 'package:dukka_test/utils/hiveVariables.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

class AddDebators extends StatefulWidget {
  const AddDebators({ Key? key }) : super(key: key);

  @override
  State<AddDebators> createState() => _AddDebatorsState();
}

class _AddDebatorsState extends State<AddDebators> {
    final _formKey = GlobalKey<FormState>();
    bool loading=false;
    Debit debit=Debit();
    Future<void> createdebit()async{
    try{
      List debits= await Hive.box(HiveVariables.debtors).get(HiveVariables.debtors,defaultValue: []);
      DateTime creationTime=DateTime.now();
      debit.creationDate=creationTime;
      debit.id=creationTime.millisecondsSinceEpoch.toString();
    debits.add(debit.toJson());
    await Hive.box(HiveVariables.debtors).put(HiveVariables.debtors, debits);
    Fluttertoast.showToast(
        msg: "debit created",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }catch(e){
      log('debit creation error',error: e.toString());
      Fluttertoast.showToast(
        msg: "Unable to create debit",
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
      appBar: AppBar(title:  const Text('Add Debitor')),
      body:Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed:loading?null: ()async{
            if(_formKey.currentState?.validate()??false){
              if(debit.dueDate==null){
                Fluttertoast.showToast(
        msg: "Select a date first",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
              }else{
                loading=!loading;
                setState(() {
                  
                });
                await createdebit();
                loading=!loading;
                setState(() {
                  
                });
              }
              
            }
          },
        ),
        body: ListView(
          children: 
            [Form(
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
                                    debit.title=title.trim();
                                  },
                                 ),
                                 TextFormField(
                                   decoration:  InputDecoration(
                                    enabled: !loading,
                                    hintText: 'Debitor Name',
                                  ),
                                  validator: FormValidators.isNotEmptyField,
                                  onChanged: (name){
                                    debit.debtor=name.trim();
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
                                    debit.amount=num.tryParse(amount.trim());
                                  },
                                 ),
                                 TextFormField(
                                   decoration:  InputDecoration(
                                    enabled: !loading,
                                    hintText: 'Email to notify',
                                  ),
                                  validator: FormValidators.isValidEmail,
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (email){
                                    debit.debtorEmail=email.trim();
                                  },
                                 ),
                                 SfDateRangePicker(
                                   selectionMode: DateRangePickerSelectionMode.single,
                                   enablePastDates: false,
                      onSelectionChanged: (DateRangePickerSelectionChangedArgs newDate){
                        debit.dueDate=newDate.value;
                      },
                     
                    ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}