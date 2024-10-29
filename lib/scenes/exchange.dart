import 'package:flutter/material.dart';

class ExchangeScene extends StatefulWidget {
  const ExchangeScene({super.key});

  @override
  State<ExchangeScene> createState() => _ExchangeSceneState();
}

class _ExchangeSceneState extends State<ExchangeScene> {
    List<String> values = ['₽', '\$', '€', '¥'];
    String selectedUnit = '₽';
    String inputValue = '';
    Map<String, String> results = {};

    final Map<String, Map<String, double>> conversionFactors = {
      'Валюта': {
        '₽': 1,
        '\$': 95.80,
        '€': 104.20,
        '¥' : 0.63
      },
    };

    void calculateResults() {
      if (inputValue.isNotEmpty && double.parse(inputValue) >= 0) {
        double value = double.parse(inputValue);
        results = {};

        for (String targetUnit in values) {
          double factorFrom = conversionFactors['Валюта']![selectedUnit]!;
          double factorTo = conversionFactors['Валюта']![targetUnit]!;
          results[targetUnit] = (value * factorFrom / factorTo).toStringAsFixed(2);
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
          title: Text('Курс'),
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
