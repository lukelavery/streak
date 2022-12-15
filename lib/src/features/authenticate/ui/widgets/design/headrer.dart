import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header(this.heading, {super.key});
  final String heading;

  @override
  Widget build(BuildContext context) => Text(
        heading,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
        ),
      );
}
