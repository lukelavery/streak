import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/authenticate/controllers/auth_controller.dart';
import 'package:streak/src/features/authenticate/ui/widgets/design/styled_button.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 8),
              child: Consumer(
                builder: ((context, ref, child) => StyledButton(
                      onPressed: (() {
                        ref.read(authControllerProvider.notifier).signOut();
                        Navigator.pop(context);
                      }),
                      child: const Text('LOGOUT'),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
