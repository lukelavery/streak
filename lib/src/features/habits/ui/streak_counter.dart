import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StreakCounter extends StatelessWidget {
  const StreakCounter(
      {Key? key,
      required this.today,
      required this.counter,
      required this.color})
      : super(key: key);

  final bool today;
  final int counter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final activeStreak = counter > 0 ? true : false;
    final Color onSurfaceColor = Theme.of(context).colorScheme.onSurface;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
        decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: today ? color.withOpacity(0.8) : color.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(7)),
        child: Row(
          textBaseline: TextBaseline.ideographic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            FaIcon(
              FontAwesomeIcons.fireFlameCurved,
              size: 20,
              color: activeStreak ? onSurfaceColor : Colors.grey,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              counter.toString(),
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: activeStreak ? onSurfaceColor : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
