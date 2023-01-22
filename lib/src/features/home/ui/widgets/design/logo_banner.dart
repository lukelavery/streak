import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LogoBanner extends StatelessWidget {
  const LogoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      clipBehavior: Clip.none,
      children: const [
        Positioned(
            left: 23,
            child: Text(
              'streak',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
            )),
        FaIcon(
          FontAwesomeIcons.bolt,
          size: 22,
        ),
      ],
    );
  }
}