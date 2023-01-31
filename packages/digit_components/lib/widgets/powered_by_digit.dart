import 'package:digit_components/digit_components.dart';
import 'package:flutter/material.dart';

class PoweredByDigit extends StatefulWidget {
  final Size? size;
  final EdgeInsets? padding;

  const PoweredByDigit({super.key, this.size, this.padding});

  @override
  State<PoweredByDigit> createState() => _PoweredByDigitState();
}

class _PoweredByDigitState extends State<PoweredByDigit> {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: Center(
          child: Container(
            height: 24,
            padding: widget.padding ?? const EdgeInsets.all(4),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/powered_by_digit.png',
              package: 'digit_components',
              color: DigitTheme.instance.colorScheme.onPrimary,
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
}
