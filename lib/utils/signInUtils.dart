import 'package:dukka_test/models/dukkaUser.dart';
import 'package:dukka_test/screens/mainHome/mainHome.dart';
import 'package:dukka_test/screens/signIn/checkSignIn.dart';
import 'package:dukka_test/screens/signIn/signIn.dart';
import 'package:dukka_test/utils/hiveVariables.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

class SignInUtils{
  ///Detects if the user is signed in and redirects the user to the proper page automatically. The [context] must be passed
  static Future<bool> isSignedIn(BuildContext context) async {
    bool signedIn=false;
    Map<String,dynamic> userData = Map<String,dynamic>.from(await Hive.box(HiveVariables.userAccountInfo).get(HiveVariables.userAccountInfo,defaultValue: {}));
    if(userData.isNotEmpty){
      signedIn=true;
      DukkaUser user=DukkaUser.fromJson(userData);
      //Navigate user to mainhome screen
      Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) =>  MainHome(user: user,)),
  );
    }else{
      //Navigate user to sign in screen
       Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const SignIn()),
  );
    }
    return signedIn;
  }
  static Future<void> signIn(DukkaUser user,BuildContext context)async {
    List usersList=await Hive.box(HiveVariables.accountsList).get(HiveVariables.accountsList,defaultValue: []);
    List<DukkaUser>usersData= List.generate(usersList.length, (index) => DukkaUser.fromJson(Map<String,dynamic>.from(usersList[index])));
    if(usersData.isEmpty){
      Fluttertoast.showToast(
        msg: "This account doesn't exist",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }else{
      bool valid=false;
      DukkaUser validUser=DukkaUser();
      for(int i=0;i<usersData.length;i++){
        if(user.email?.trim()==usersData[i].email&&user.password==usersData[i].password){
          valid=true;
          validUser=usersData[i];
          Hive.box(HiveVariables.userAccountInfo).put(HiveVariables.userAccountInfo, usersData[i].toJson());
          break;
        }
      }
      if(valid){
        //Navigate to mainHome
         Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) =>  MainHome(user:validUser ,)),
  );
      }else{
        //The user entered wrong credintials
        Fluttertoast.showToast(
        msg: "This account doesn't exist",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
      }
    }
  }
  static Future<void> signOut(BuildContext context)async{
    await Hive.box(HiveVariables.userAccountInfo).delete(HiveVariables.userAccountInfo);
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) =>  const CheckSignIn()),
  );
  }
}