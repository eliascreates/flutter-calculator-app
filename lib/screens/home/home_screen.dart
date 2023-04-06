import 'package:calculator_app/models/calculator_model.dart';
import 'package:flutter/material.dart';
import 'package:calculator_app/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> calculatorSymbols = const [
    "C",
    "+/-",
    "%",
    "/",
    "9",
    "8",
    "7",
    "X",
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
    "<",
    "="
  ];
  final Calculator _calculator = Calculator();

  void updateUI() {
    setState(() {
      _calculator.result;
    });
  }

  bool isOperator(String symbol) {
    if (symbol == "/" ||
        symbol == "X" ||
        symbol == "-" ||
        symbol == "+" ||
        symbol == "=") {
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
            Expanded(
              flex: 1,
              child: Container(
                color: kPrimarycolor,
                padding: EdgeInsets.all(kDefaultPadding / 2),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    _calculator.result,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ),
            SizedBox(height: kDefaultPadding / 2),
            Expanded(
              flex: 2,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, childAspectRatio: 1),
                itemCount: calculatorSymbols.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => CalculatorButton(
                  onPress: () {
                    //*Clear Button
                    setState(() {
                      _calculator.result += calculatorSymbols[index];

                      if (_calculator.result[0] == "0") {
                        _calculator.result = _calculator.result.substring(1);
                      }
                      if (index == 0) {
                        _calculator.clear();
                      }

                      if (calculatorSymbols[index] == '<') {
                        _calculator.delete();
                        debugPrint("should delete");
                      }

                      if (isOperator(calculatorSymbols[index])) {
                        _calculator.operator = calculatorSymbols[index];
                      }

                      if(calculatorSymbols[index] == "=") {
                        
                      }


                    });
                  },
                  symbol: calculatorSymbols[index],
                  color: (isOperator(calculatorSymbols[index]))
                      ? kSecoundarycolor
                      : kButtonColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  const CalculatorButton(
      {super.key,
      required this.onPress,
      required this.symbol,
      this.color = Colors.white});

  final String symbol;
  final Color color;
  final VoidCallback onPress;
  // final width
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(kDefaultPadding),
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.all(kDefaultPadding * 0.2),
        padding: EdgeInsets.all(kDefaultPadding / 2),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.white,
                blurRadius: 2,
                spreadRadius: kDefaultPadding * 0.05),
            BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 4,
                spreadRadius: kDefaultPadding * 0.1),
          ],
          borderRadius: BorderRadius.circular(kDefaultPadding),
          color: color,
        ),
        child: Center(
          child: (symbol == "/")
              ? SvgPicture.asset(
                  "assets/icons/divide.svg",
                  height: 35,
                )
              : (symbol == "X")
                  ? const Icon(Icons.close)
                  : (symbol == "<")
                      ? const Icon(Icons.backspace_outlined)
                      : Text(symbol, style: const TextStyle(fontSize: 25)),
        ),
      ),
    );
  }
}
