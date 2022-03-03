import 'package:dukka_test/models/dukkaUser.dart';
import 'package:dukka_test/screens/signUp/signUp.dart';
import 'package:dukka_test/utils/formValidators.dart';
import 'package:dukka_test/utils/signInUtils.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({ Key? key }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  DukkaUser user=DukkaUser();
  bool loading=false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In'),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                 children:  [
                   TextFormField(
                     decoration:  InputDecoration(
                      enabled: !loading,
                      hintText: 'Email',
                    ),
                    validator: FormValidators.isValidEmail,
                    onChanged: (email){
                      user.email=email.trim();
                    },
                   ),
                   TextFormField(
                     enabled: !loading,
                     keyboardType: TextInputType.visiblePassword,
                     decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: FormValidators.isNotEmptyField,
                    onChanged: (password){
                      user.password=password.trim();
                    },
                   ),
                   TextButton(
                     child: const Text('Sign In'),
                     onPressed: loading?null: ()async{
                       if(_formKey.currentState?.validate()??false){
                         loading=!loading;
                       setState(() {
                         
                       });
                       await SignInUtils.signIn(user, context);
                       loading=!loading;
                       setState(() {
                         
                       });
                       }else{
          
                       }
                     },
                   ),
                  TextButton(
                     child: const Text('Sign Up',style: TextStyle(color: Colors.green,)),
                     onPressed: loading?null: ()async{
                       Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) =>  const SignUp()),
  );
                     },
                   )
                 ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}