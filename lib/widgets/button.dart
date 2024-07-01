import 'package:bni_mobile/app/env/colors.dart';
import 'package:flutter/material.dart';

import 'text.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  PrimaryButton(
      {Key? key,
      required this.text,
      required this.onTap,
      this.backgroundColor = primaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: CText(
            text,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class SmallButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  SmallButton(
      {Key? key,
      required this.text,
      required this.onTap,
      this.backgroundColor = primaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: CText(
            text,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const SecondaryButton({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: CText(
            text,
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
