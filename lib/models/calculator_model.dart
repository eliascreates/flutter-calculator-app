import 'package:flutter/material.dart';

enum Operator {
  add,
  subtract,
  multiply,
  divide,
}

class Calculator {
  String result = "0";
  double initialValue = 0;

  Operator? _operator;

  set operator(String symbol) {
    initialValue = result as double;

    switch (symbol) {
      // case "+/-":
      //   break;
      // case "%":
      //   break;
      case "/":
        _operator = Operator.divide;
        debugPrint("Divide");
        break;
      case "X":
        _operator = Operator.multiply;
        debugPrint("Multiply");
        break;
      case "-":
        _operator = Operator.subtract;
        debugPrint("Subtract");
        break;
      case "+":
        _operator = Operator.add;
        debugPrint("Add");
        break;
      // case ".":
      //   break;
      // case "<":
      //   break;
      // case "=":
      //   break;
    }
  }

  void calculate(double first, double last) {
    switch (_operator) {
      case Operator.add:
        initialValue += first + last;
        break;
      case Operator.subtract:
        initialValue += first - last;
        break;
      case Operator.multiply:
        initialValue += first * last;
        break;
      case Operator.divide:
        initialValue += first / last;
        break;
      case null:
        return;
    }
    result = initialValue as String;
  }

  // void _add(double n) {}
  // void _multiply(double n) {}
  // void _subtract(double n) {}
  // void _divide(double n) {}

  void clear() {
    result = "0";
    _operator = null;
  }

  void delete() {
    result = result.substring(0, result.length - 2);
  }
}
