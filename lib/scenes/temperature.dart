import 'package:flutter/material.dart';

class TempScene extends StatefulWidget {
  const TempScene({super.key});

  @override
  State<TempScene> createState() => _TempSceneState();
}

class _TempSceneState extends State<TempScene> {
  List<String> values = ['t', 'F', 'K'];
  String selectedUnit = 't';
  String inputValue = '';
  Map<String, String> results = {};

  void calculateResults() {
    if (inputValue.isNotEmpty) {
      double value = double.parse(inputValue);
      results = {};

      for (String targetUnit in values) {

        if (targetUnit == 't' && selectedUnit == 'F') {
          results[targetUnit] = ((value - 32) * 5/9).toStringAsFixed(2);
        } else if (targetUnit == 'F' && selectedUnit == 't') {
          results[targetUnit] = ((value * 9/5) + 32).toStringAsFixed(2);
        } else if (targetUnit == 't' && selectedUnit == 'K') {
          results[targetUnit] = (value - 273.15).toStringAsFixed(2);
        } else if (targetUnit == 'K' && selectedUnit == 't') {
          results[targetUnit] = (value + 273.15).toStringAsFixed(2);
        } else if (targetUnit == 'F' && selectedUnit == 'K') {
          results[targetUnit] = (((value - 273.15) * 9/5) + 32).toStringAsFixed(2);
        } else if (targetUnit == 'K' && selectedUnit == 'F') {
          results[targetUnit] = (((value - 32) * 5/9) + 273.15).toStringAsFixed(2);
        } else {
          results[targetUnit] = (value).toStringAsFixed(2);
        }
      }
    } else {
      for (String targetUnit in values) {
        results[targetUnit] = '';
      }
    }
    setState(() {});
  }

  bool isValidInput(String input) {
    RegExp numberRegex = RegExp(r'^[-+]?\d+(\.\d*)?$');
    return numberRegex.hasMatch(input);
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Температура'),
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
