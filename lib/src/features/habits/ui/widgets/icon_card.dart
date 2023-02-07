import 'package:flutter/material.dart';

class IconCard extends StatelessWidget {
  const IconCard({Key? key, required this.icon, required this.selected})
      : super(key: key);

  final Icon icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0.5,
      child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: selected
                ? Border.all(color: Theme.of(context).colorScheme.primary)
                : null,
          ),
          child: icon),
    );
  }
}