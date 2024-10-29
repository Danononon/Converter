import 'package:flutter/material.dart';

class TimeScene extends StatefulWidget {
  const TimeScene({super.key});

  @override
  State<TimeScene> createState() => _TimeSceneState();
}

class _TimeSceneState extends State<TimeScene> {
  List<String> values = ['с', 'мин', 'ч', 'день'];
  String selectedUnit = 'с';
  String inputValue = '';
  Map<String, String> results = {};

  final Map<String, Map<String, double>> conversionFactors = {
    'Время': {
      'с': 604800,
      'мин': 10080,
      'ч': 168,
      'день': 7,
    },
  };

  void calculateResults() {
    if (inputValue.isNotEmpty && double.parse(inputValue) >= 0) {
      double value = double.parse(inputValue);
      results = {};

      for (String targetUnit in values) {
        double factorTo = conversionFactors['Время']![selectedUnit]!;
        double factorFrom = conversionFactors['Время']![targetUnit]!;
        results[targetUnit] = (value * factorFrom / factorTo).round().toString();
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
        title: Text('Время'),
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
                  items: values.map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  )).toList(),
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
              child: Text('Конвертированные результаты:',
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
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                }
                return SizedBox.shrink();
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
