import 'package:dukka_test/models/dukkaUser.dart';
import 'package:dukka_test/screens/mainHome/debtors/debtorsList.dart';
import 'package:dukka_test/screens/mainHome/expenses/expensesList.dart';
import 'package:dukka_test/screens/signIn/signIn.dart';
import 'package:dukka_test/utils/signInUtils.dart';
import 'package:flutter/material.dart';

class MainHome extends StatefulWidget {
  static String route='mainHome';
  final DukkaUser user;
  const MainHome({ Key? key, required this.user }) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            actions: [IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: (){
                SignInUtils.signOut(context);
              },
            )],
            bottom:  const TabBar(
              tabs: [
                Tab(child: Text('Expenses')),
                Tab(child: Text('Debtors'),),
              ],
            ),
            title: const Text('Dukka'),
          ),
          body:  TabBarView(
            children: [
              ExpensesList(user: widget.user,),
              DebatorsList(user: widget.user,),
            ],
          ),
        ),
      ),
    );
  }
}