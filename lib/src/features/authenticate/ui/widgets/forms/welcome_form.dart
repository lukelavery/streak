import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streak/src/features/authenticate/ui/widgets/design/text.dart';

class WelcomeForm extends StatelessWidget {
  const WelcomeForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header1('Track your habits.'),
          const SizedBox(
            height: 5,
          ),
          const Header2('Achieve your goals.'),
        ],
      ),
    );
  }
}
