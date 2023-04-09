import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final onSaved;
  final validate;

  const CustomTextField(
      {super.key,
      required this.label,
      required this.onSaved,
      required this.validate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.only(left: 15.0),
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(15.0)),
        child: TextFormField(
          onSaved: onSaved,
          validator: validate,
          decoration: InputDecoration(
            border: InputBorder.none,
            label: Center(child: Text(label)),
          ),
        ),
      ),
    );
  }
}
