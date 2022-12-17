import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key, this.hintText, this.setText, this.enabled, this.initialValue, required this.obscureText})
      : super(key: key);

  final String? hintText;
  final void Function(String email)? setText;
  final bool? enabled;
  final String? initialValue;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      initialValue: initialValue,
      enabled: enabled,
      onChanged: (value) {
        if (setText != null) {
          setText!(value);
        }
      },
      style: const TextStyle(
        color: Colors.black,
        fontFamily: 'Montserrat',
      ),
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
