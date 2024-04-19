import 'package:flutter/material.dart';
import 'package:flutter_demo/Authentication/login.dart';
import 'package:flutter_demo/Authentication/signup.dart';
import 'package:flutter_demo/Views/notes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  Notes(),
    );
  }
}