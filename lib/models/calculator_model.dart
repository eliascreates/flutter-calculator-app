import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator {
  String result = "0", operator = "", _history = "";
  String get history => _history;

  static List<String> symbols = const [
    "C",
    "±",
    "%",
    "÷",
    "9",
    "8",
    "7",
    "x",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "<", //cancel action (backspace)
    "="
  ];

  void calculate() {
    _history = result;
    Parser p = Parser();
    String evaluate = result.replaceAll("x", "*");
    evaluate = evaluate.replaceAll("÷", "/");

    try {
      Expression exp = p.parse(evaluate);

      result = exp.evaluate(EvaluationType.REAL, ContextModel()).toString();
    } catch (e) {
      clear();
    }
  }

  void clear() {
    result = "0";
    operator = "";
  }

  void delete() {
    result = result.substring(0, result.length - 1);
    if (result.isEmpty) {
      debugPrint("Is Empty");
      result = "0";
      operator = "";
    }
  }
}
