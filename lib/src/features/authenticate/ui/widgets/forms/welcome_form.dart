import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:streak/src/features/authenticate/ui/widgets/design/text.dart';

class WelcomeForm extends StatelessWidget {
  const WelcomeForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Header1('Track your habits.'),
                    SizedBox(height: 5,),
                    Header2('Achieve your goals.')
                  ],
                )),
          ],
        );
  }
}