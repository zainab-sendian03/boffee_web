import 'package:flutter/material.dart';
import 'package:hello/view/addpage.dart';
import 'package:hello/view/homepage.dart';
import 'package:hello/view/login.dart';
import 'package:hello/view/Navigation.dart';
import 'package:hello/forgetpassword/getcode.dart';
import 'package:hello/forgetpassword/maiadd.dart';

import 'view/test.dart';


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      
    home: SideMenue(),
    
    );
   
  }
}
