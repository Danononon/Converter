import 'package:flutter/material.dart';
import 'package:untitled5/scenes/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurple[300],
      ),
      home: HomePage(),
    );
  }
}
