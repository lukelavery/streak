import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/theme/theme.dart';
import 'package:streak/src/features/authenticate/controllers/auth_controller.dart';
import 'package:streak/src/features/authenticate/domain/user_model.dart';
import 'package:streak/src/features/theme/ui/color_picker_view.dart';

class UserProfilePage extends ConsumerWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateNotifier = ref.read(authControllerProvider.notifier);
    final UserModel user = ref.read(authControllerProvider);
    final themeState = ref.watch(themeController);
    final themeStateNotifier = ref.read(themeController.notifier);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                authStateNotifier.signOut();
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).colorScheme.onSurface,
              ))
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(user.photoUrl!),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                user.name!,
                style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                user.email!,
                style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SettingsListTile(
                      title: 'Dark Mode',
                      trailing: Switch(
                          activeColor: Colors.blue,
                          value: themeState.darkMode,
                          onChanged: (value) {
                            themeStateNotifier.toggleDarkMode();
                          }),
                    ),
                    SettingsListTile(
                        title: 'Colour',
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SelectColorView()))
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsListTile extends StatelessWidget {
  const SettingsListTile(
      {super.key, required this.title, required this.trailing, this.onTap});

  final String title;
  final Widget trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 0,
        child: ListTile(
          title: Text(title),
          trailing: trailing,
        ),
      ),
    );
  }
}
