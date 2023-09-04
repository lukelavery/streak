import 'package:flutter/material.dart';
import 'package:streak/src/features/activities/ui/pages/select_icon_page.dart';

class SmallButton extends StatelessWidget {
  const SmallButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SelectIconPage()));
      },
      child: Container(
        width: 100,
        height: 35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: colorScheme.primary.withOpacity(0.7)),
        child: Center(
            child: Text(
          'More icons',
          style: TextStyle(
              color: colorScheme.onInverseSurface, fontWeight: FontWeight.w500),
        )),
      ),
    );
  }
}
