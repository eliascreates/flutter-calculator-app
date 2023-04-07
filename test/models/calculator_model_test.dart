import 'package:calculator_app/models/calculator_model.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  late Calculator calculator;
  setUp(() {
    calculator = Calculator();
  });
  group('Calculator class -', () {
    test(
        'Given the Calculator class when clear function is called then result = 0',
        () {
      //Arrange

      //Act
      calculator.clear();
      //Assert

      expect(calculator.result, "0");
    });
    test(
        'Given the calculator class when calculate function is called then result calculates expression with correct answer 5+5*2+3 = 18',
        () {
      //Arrange
      calculator.result = "5+5*2+3";
      //Act
      calculator.calculate();
      //Assert
      expect(calculator.result, "18.0");
    });

    test(
        'Given the Calculator class when delete function is called then one character from result property is removed',
        () {
      //Arrange
      calculator.result = "50+25";
      //Act
      calculator.delete();
      //Assert
      expect(calculator.result, "50+2");
    });
  });
}
