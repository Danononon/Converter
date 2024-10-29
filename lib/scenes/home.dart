import 'package:flutter/material.dart';
import 'package:untitled5/scenes/weight.dart';
import 'package:untitled5/scenes/exchange.dart';
import 'package:untitled5/scenes/length.dart';
import 'package:untitled5/scenes/temperature.dart';
import 'package:untitled5/scenes/time.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<String, Widget Function(BuildContext)> categories = {
    'Вес': (context) => WeightScene(),
    'Валюта': (context) => ExchangeScene(),
    'Температура': (context) => TempScene(),
    'Расстояние': (context) => LengthScene(),
    'Время': (context) => TimeScene(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        title: Text('Конвертер',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28,
          color: Colors.white,
        ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: categories.keys.length,
          itemBuilder: (BuildContext context, int index) {
            final category = categories.keys.elementAt(index);
            final screenBuilder = categories[category]!;
            return TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => screenBuilder(context),
                  ),
                );
              },
              child: Text(
                category,
                style: TextStyle(fontSize: 18),
              ),
            );
          }),
    );
  }
}