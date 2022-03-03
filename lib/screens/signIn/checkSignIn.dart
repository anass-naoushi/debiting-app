import 'dart:developer';

import 'package:dukka_test/utils/signInUtils.dart';
import 'package:flutter/material.dart';

class CheckSignIn extends StatefulWidget {
  const CheckSignIn({ Key? key }) : super(key: key);

  @override
  State<CheckSignIn> createState() => _CheckSignInState();
}

class _CheckSignInState extends State<CheckSignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<bool>(
          future: SignInUtils.isSignedIn(context),
          builder: (contex,isSignedIn){
            if(isSignedIn.hasError){
              log('sign in check error',error: isSignedIn.error);
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Unable to check if user is signed in',style: TextStyle(color: Colors.black),),
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
            }else if(!isSignedIn.hasData){
              return const Center(child: CircularProgressIndicator(),);
            }else {
              return const Center(child: Icon(Icons.check,color: Colors.green,),);
            }
          },
        ),
      ),
    );
  }
}

