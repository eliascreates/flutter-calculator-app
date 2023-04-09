import 'package:calculator_app/constants.dart';
import 'package:calculator_app/models/calculator_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalculatorConsole extends StatelessWidget {
  const CalculatorConsole({
    super.key,
    required this.calculator,
    required this.isUp,
  });

  final Calculator calculator;
  final bool isUp;

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();

    controller.text = calculator.result;
    return Expanded(
      flex: 1,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: kBgColorDark,
              padding: EdgeInsets.symmetric(
                  vertical: kDefaultPadding / 2,
                  horizontal: kDefaultPadding * 0.25),
              child: Align(
                alignment: Alignment.bottomRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  child: Text(
                    calculator.result,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    selectionColor: Colors.blue,
                    style: TextStyle(
                        fontSize: 30, color: kTextColor.withOpacity(0.9)),
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            bottom: 60,
            right: isUp ? 10 : -50,
            duration: const Duration(milliseconds: 500),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: isUp ? 1 : 0,
              child: Text(
                calculator.history,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.grey),
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 10,
            child: SvgPicture.asset(
              "assets/icons/math-symbols.svg",
              height: 40,
              colorFilter: ColorFilter.mode(kBgColor, BlendMode.softLight),
            ),
          )
        ],
      ),
    );
  }
}
