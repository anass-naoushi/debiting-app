import 'dart:developer';

import 'package:dukka_test/models/debit.dart';
import 'package:dukka_test/models/dukkaUser.dart';
import 'package:dukka_test/screens/mainHome/debtors/addDebitors.dart';
import 'package:dukka_test/utils/hiveVariables.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:url_launcher/url_launcher.dart';

class DebatorsList extends StatefulWidget {
  final DukkaUser user;
  const DebatorsList({ Key? key,required this.user }) : super(key: key);

  @override
  State<DebatorsList> createState() => _DebatorsListState();
}

class _DebatorsListState extends State<DebatorsList> {
  Future<List<Debit>> getDebtors()async{
     List debits=Hive.box(HiveVariables.debtors).get(widget.user.userId,defaultValue: []);
    log(debits.toString(),name: 'Debits');
    List<Debit> debitsList=List.generate(debits.length, (index) => Debit.fromJson(Map<String,dynamic>.from(debits[index])));
    return debitsList;
  }
  void _launchURL(String? url) async {
  if (!await launch(url!)) throw 'Could not launch $url';
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child:const Icon(Icons.add),
        onPressed: ()async{
          await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>   AddDebators(user: widget.user,)),
  );
  setState(() {
    
  });
        },
      ),
      body: FutureBuilder<List<Debit>>(
        future: getDebtors(),
        builder: (context,debitsList){
          if(debitsList.hasError){
            log('debtors error',error: debitsList.error);
            return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Unable to check user debits',style: TextStyle(color: Colors.black),),
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
          }else if(!debitsList.hasData){
            return const Center(child: CircularProgressIndicator(),);
          }else{
            if(debitsList.data!.isEmpty){
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('No Debits'),
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
                itemCount: debitsList.data!.length,
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(debitsList.data![index].title??''),
                                Text('\$'+debitsList.data![index].amount.toString()),
                              ],
                            ),
                            Column(
                              children: [
                                Text('Email:${debitsList.data![index].debtorEmail}'),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Text('Due date:'),
                                      Text(DateFormat('yyyy-MM-dd hh:mm').format(debitsList.data![index].dueDate??DateTime.now())),
                                    ],
                                  ),
                                ),
                                (debitsList.data![index].dueDate!=null&&debitsList.data![index].dueDate!.isAfter(DateTime.now()))?
                                SlideCountdown(
                                  infinityCountUp: false,
  duration: debitsList.data![index].dueDate!.difference(DateTime.now()),
)
                                :Container(),
                                TextButton(
                                  child: const Text('Notify'),
                                  onPressed: (){
                                    if(!DateTime.now().isAfter(debitsList.data![index].dueDate??DateTime.now())){
                                      //due, send email
                                      final Uri uri = Uri(
                                          scheme: 'mailto',
                                          path: debitsList.data![index].debtorEmail!.trim(),
                                          query: 'subject=Payment Due&body=Hello ${debitsList.data![index].debtor}, please complete your payment for ${debitsList.data![index].title}, its due.', //add subject and body here
                                        );
                                      _launchURL(uri.toString());
                                    }else{
                                      Fluttertoast.showToast(
        msg: "The debit is not due yet",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
                                    }
                                  },
                                )
                              ],
                            )
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