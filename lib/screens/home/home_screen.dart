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
    "<",
    "="
  ];
  bool _isUp = false;
  final Calculator _calculator = Calculator();

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
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      color: kBgColorDark,
                      padding: EdgeInsets.all(kDefaultPadding / 2),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          _calculator.result,
                          style: TextStyle(
                              fontSize: 30, color: kTextColor.withOpacity(0.9)),
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    bottom: 60,
                    right: _isUp ? 10 : -50,
                    duration: const Duration(milliseconds: 500),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      opacity: _isUp ? 1 : 0,
                      child: Text(
                        _calculator.history,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.grey),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 20,
                      right: 20,
                      child: SvgPicture.asset(
                        "assets/icons/math-symbols.svg",
                        height: 40,
                        colorFilter:
                            ColorFilter.mode(kBgColor, BlendMode.softLight),
                      ))
                ],
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
                    } else if (isOperator(calculatorSymbols[index])) {
                      return CalculatorButton(
                        onPress: () {
                          setState(() {
                            _calculator.result += calculatorSymbols[index];
                          });
                        },
                        symbol: calculatorSymbols[index],
                        color: (index == 1 || index == 2)
                            ? kSecoundarycolor.withOpacity(0.5)
                            : kSecoundarycolor,
                      );
                    } else if (calculatorSymbols[index] == '<') {
                      return CalculatorButton(
                        onPress: () => setState(() => _calculator.delete()),
                        symbol: calculatorSymbols[index],
                        color: kPrimarycolor.withOpacity(0.7),
                      );
                      //*Equal Sign
                    } else if (index == 19) {
                      return CalculatorButton(
                        onPress: () => setState(() {
                          _isUp = true;
                          _calculator.calculate();
                        }),
                        symbol: calculatorSymbols[index],
                        color: const Color(0xFF54bf9f),
                      );
                    } else {
                      return CalculatorButton(
                        onPress: () {
                          setState(() {
                            _calculator.result += calculatorSymbols[index];
                            if (_calculator.result[0] == "0") {
                              _calculator.result =
                                  _calculator.result.substring(1);
                            }
                          });
                        },
                        symbol: calculatorSymbols[index],
                        color: kButtonColor,
                      );
                    }
                  }),
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
      required this.color});

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
                color: kPrimarycolor.withOpacity(0.3),
                blurRadius: 1,
                spreadRadius: 1,
                offset: const Offset(-1, 1)),
          ],
          borderRadius: BorderRadius.circular(kDefaultPadding),
          color: color,
        ),
        child: Center(
          child: (symbol != "<" && symbol != "±")
              ? Text(symbol, style: TextStyle(fontSize: 25, color: kTextColor))
              : (symbol == "±")
                  ? Image.asset(
                      "assets/icons/plus_or_minus.png",
                      height: 20,
                      color: kTextColor,
                    )
                  : Icon(
                      Icons.backspace_outlined,
                      color: kTextColor,
                    ),
        ),
      ),
    );
  }
}
