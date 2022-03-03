import 'dart:io';

import 'package:dukka_test/screens/signIn/checkSignIn.dart';
import 'package:dukka_test/utils/hiveVariables.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  await Hive.openBox(HiveVariables.accountsList);
  await Hive.openBox(HiveVariables.userAccountInfo);
  await Hive.openBox(HiveVariables.debtors);
  await Hive.openBox(HiveVariables.userExpenses);
  //await Hive.deleteFromDisk();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dukka Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CheckSignIn(),
    );
  }
}

