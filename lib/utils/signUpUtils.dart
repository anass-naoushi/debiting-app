import 'package:dukka_test/models/dukkaUser.dart';
import 'package:dukka_test/screens/mainHome/mainHome.dart';
import 'package:dukka_test/utils/hiveVariables.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

class SignUpUtils{
  static Future<DukkaUser> signUp(DukkaUser user,BuildContext context)async{
    List accounts=await Hive.box(HiveVariables.accountsList).get(HiveVariables.accountsList,defaultValue: []);
    for(int i=0;i<accounts.length;i++){
      DukkaUser oldUser=DukkaUser.fromJson(Map<String,dynamic>.from(accounts[i]));
      if(user.email!.trim()==oldUser.email?.trim()){
        Fluttertoast.showToast(
        msg: "This email is already in use",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    return user;
      }
      
    }
    DateTime creationTime=DateTime.now();
    user.userId= creationTime.millisecondsSinceEpoch.toString();
    user.creationDate=creationTime;
    await Hive.box(HiveVariables.userAccountInfo).put(HiveVariables.userAccountInfo, user.toJson());
    accounts.add(user.toJson());
    await Hive.box(HiveVariables.accountsList).put(HiveVariables.accountsList, accounts);
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) =>  MainHome(user:user,)),
  );
    return user;
  }
}