import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeightScene extends StatefulWidget {
  const WeightScene({super.key});

  @override
  State<WeightScene> createState() => _WeightSceneState();
}

class _WeightSceneState extends State<WeightScene> {
  List<String> values = ['кг', 'г', 'фунты', 'пуд'];
  String selectedUnit = 'кг';
  String inputValue = '';
  Map<String, String> results = {};

  final Map<String, Map<String, double>> conversionFactors = {
    'Вес': {
      'кг': 1,
      'г': 1000,
      'фунты': 0.453592,
      'пуд' : 0.061
    },
  };

  void calculateResults() {
    NumberFormat formatter = NumberFormat('#.####');
    if (inputValue.isNotEmpty) {
      double value = double.parse(inputValue);
      results = {};

      for (String targetUnit in values) {
        double factorTo = conversionFactors['Вес']![selectedUnit]!;
        double factorFrom = conversionFactors['Вес']![targetUnit]!;
        results[targetUnit] = formatter.format(value * factorFrom / factorTo);
      }
    } else {
      for (String targetUnit in values) {
        results[targetUnit] = '';
      }
    }
    setState(() {});
  }

  bool isValidInput(String input) {
    RegExp numberRegex = RegExp(r'^\d+(\.\d*)?$');
    return numberRegex.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Вес'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (text) {
                      setState(() {
                        inputValue = text;
                        if (isValidInput(inputValue)) {
                          calculateResults();
                        } else {
                          results = {};
                        }
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Введите значение',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                DropdownButton<String>(
                  value: selectedUnit,
                  hint: Text('Единицы'),
                  items: values
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedUnit = value!;
                      calculateResults();
                    });
                  },
                ),
              ],
            ),
            if (isValidInput(inputValue))
              Center(
                child: Text(
                  'Конвертированные результаты:',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            if (isValidInput(inputValue))
              Column(
                children: values.map((unit) {
                  if (unit != selectedUnit) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple[200],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '$unit: ${results[unit] ?? ''}',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                }).toList(),
              ),
            if (!isValidInput(inputValue) && inputValue.trim() != '')
              Center(
                child: Text(
                  'Неверно введено значение',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (inputValue.trim() == '') SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
