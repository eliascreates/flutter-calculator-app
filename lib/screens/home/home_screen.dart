import 'package:calculator_app/models/calculator_model.dart';
import 'package:flutter/material.dart';
import 'package:calculator_app/constants.dart';
import 'components/calculator_button.dart';
import 'components/calculator_console.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> calculatorSymbols = Calculator.symbols;
  final Calculator _calculator = Calculator();
  bool _isUp = false;
  bool isOperator(String symbol) {
    if (symbol == "÷" ||
        symbol == "x" ||
        symbol == "-" ||
        symbol == "+" ||
        symbol == "±" ||
        symbol == "%") {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CalculatorConsole(calculator: _calculator, isUp: _isUp),
            SizedBox(height: kDefaultPadding / 2),
            Expanded(
              flex: 2,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, childAspectRatio: 1),
                itemCount: calculatorSymbols.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  //*Clear Button
                  if (index == 0) {
                    return CalculatorButton(
                      onPress: () => setState(() {
                        _isUp = false;
                        _calculator.clear();
                      }),
                      symbol: calculatorSymbols[index],
                      color: kPrimarycolor.withOpacity(0.7),
                    );
                    //*Operator Buttons
                  } else if (isOperator(calculatorSymbols[index])) {
                    return CalculatorButton(
                      onPress: () {
                        setState(() {
                          if (isOperator(_calculator
                              .result[_calculator.result.length - 1])) {
                            _calculator.result = _calculator.result
                                .substring(0, _calculator.result.length - 1);
                          }

                          _calculator.result += calculatorSymbols[index];
                          _calculator.operator = calculatorSymbols[index];

                          if (_calculator.result[0] == "0") {
                            _calculator.result =
                                _calculator.result.substring(1);
                          }
                        });
                      },
                      symbol: calculatorSymbols[index],
                      color: (index == 1 || index == 2)
                          ? kSecoundarycolor.withOpacity(0.5)
                          : kSecoundarycolor,
                    );
                    //*Delete/Cancel Sign
                  } else if (calculatorSymbols[index] == '<') {
                    return CalculatorButton(
                      onPress: () => setState(() => _calculator.delete()),
                      symbol: calculatorSymbols[index],
                      color: kPrimarycolor.withOpacity(0.7),
                    );
                    //*Equal Sign
                  } else if (index == 17) {
                    return CalculatorButton(
                        onPress: () {
                          setState(
                            () {
                              if (!_calculator.result.contains(".")) {
                                _calculator.result += calculatorSymbols[index];
                              } else if (_calculator.operator.isNotEmpty) {
                                if (!_calculator.result
                                    .substring(_calculator.result
                                        .lastIndexOf(_calculator.operator))
                                    .contains(".")) {
                                  _calculator.result +=
                                      calculatorSymbols[index];
                                }
                              }
                            },
                          );
                        },
                        symbol: calculatorSymbols[index],
                        color: kButtonColor);
                  } else if (index == 19) {
                    return CalculatorButton(
                      onPress: () => setState(() {
                        _isUp = true;
                        _calculator.calculate();
                      }),
                      symbol: calculatorSymbols[index],
                      color: kAccentColor,
                    );
                    //* Number symbols
                  } else {
                    return CalculatorButton(
                      onPress: () {
                        setState(
                          () {
                            _calculator.result += calculatorSymbols[index];
                            if (_calculator.result[0] == "0") {
                              _calculator.result =
                                  _calculator.result.substring(1);
                            }
                          },
                        );
                      },
                      symbol: calculatorSymbols[index],
                      color: kButtonColor,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
