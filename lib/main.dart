import 'package:flutter/material.dart';
import 'package:greenkart/views/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenKart',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: const HomePage()
    );
  }
}



