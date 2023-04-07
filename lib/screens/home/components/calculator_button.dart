import 'package:calculator_app/constants.dart';
import 'package:flutter/material.dart';

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
