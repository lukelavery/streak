import 'package:flutter/material.dart';
import 'package:streak/src/features/authenticate/ui/widgets/design/text.dart';

class WelcomeForm extends StatelessWidget {
  const WelcomeForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Header1('Track your habits.'),
          SizedBox(
            height: 5,
          ),
          Header2('Achieve your goals.'),
        ],
      ),
    );
  }
}
