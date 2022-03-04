import 'package:dukka_test/models/dukkaUser.dart';
import 'package:dukka_test/screens/mainHome/mainHome.dart';
import 'package:dukka_test/screens/signIn/signIn.dart';
import 'package:dukka_test/utils/formValidators.dart';
import 'package:dukka_test/utils/signUpUtils.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({ Key? key }) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading=false;
  DukkaUser user=DukkaUser();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     TextFormField(
                       decoration:  InputDecoration(
                        enabled: !loading,
                        hintText: 'User name',
                      ),
                      validator: FormValidators.isNotEmptyField,
                      onChanged: (userName){
                        user.userName=userName.trim();
                      },
                     ),
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
                       decoration:  InputDecoration(
                        enabled: !loading,
                        hintText: 'Password',
                      ),
                      validator: FormValidators.isValidPassword,
                      onChanged: (pass){
                        user.password=pass.trim();
                      },
                     ),
                     TextButton(
                       child: const Text('Sign Up'),
                       onPressed: loading?null: ()async{
                         if(_formKey.currentState?.validate()??false){
                           loading=!loading;
                         setState(() {
                           
                         });
                         await SignUpUtils.signUp(user, context);
                         loading=!loading;
                         setState(() {
                           
                         });
                         }
                       },
                     ),
                     TextButton(
                       child: const Text('Sign In',style: TextStyle(color: Colors.green),),
                       onPressed: loading?null: (){
                         Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) =>  const SignIn()),
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