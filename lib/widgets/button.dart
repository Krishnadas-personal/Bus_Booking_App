import 'package:flutter/material.dart';

class LongButton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final Color textColor;
  final onTap;
  const LongButton(
      {super.key,
      required this.text,
      required this.buttonColor,
      required this.textColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14.0),
      child: MaterialButton(
        padding: const EdgeInsets.all(14.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        color: buttonColor,
        onPressed: onTap,
        child: Text(text,
            style: TextStyle(
                color: textColor, fontSize: 18.0, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
