import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

enum Operator {
  add,
  subtract,
  multiply,
  divide,
}

class Calculator {
  String result = "0";
  String _history = "";

  String get history => _history;

  void calculate() {
    _history = result;
    Parser p = Parser();
    String evaluate = result.replaceAll("x", "*");
    evaluate = evaluate.replaceAll("÷", "/");
    Expression exp = p.parse(evaluate);
    result = exp.evaluate(EvaluationType.REAL, ContextModel()).toString();
  }

  void clear() {
    result = "0";
  }

  void delete() {
    result = result.substring(0, result.length - 1);
    if (result.isEmpty) {
      debugPrint("Is Empty");
      result = "0";
    }
  }
}
