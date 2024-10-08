import 'package:flutter/material.dart';
import 'package:hello/core/config/options.dart';
import 'package:hello/view/Navigation.dart';
import 'package:hello/view/auth/login.dart';
//import 'package:hello/view/auth/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: pref!.getString('token') == null ? LoginPage() : SideMenue(),
    );
  }
}
