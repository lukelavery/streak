import 'package:flutter/material.dart';

class Header1 extends StatelessWidget {
  const Header1(this.heading, {super.key});
  final String heading;

  @override
  Widget build(BuildContext context) => Text(
        heading,
        style: TextStyle(
          fontSize: 24,
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.w400,
        ),
      );
}

class Header2 extends StatelessWidget {
  const Header2(this.heading, {super.key});
  final String heading;

  @override
  Widget build(BuildContext context) => Text(
        heading,
        style: TextStyle(
          fontSize: 20,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
          fontWeight: FontWeight.w300,
        ),
      );
}

class Header3 extends StatelessWidget {
  const Header3(this.heading, {super.key});
  final String heading;

  @override
  Widget build(BuildContext context) => Text(
        heading,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      );
}
