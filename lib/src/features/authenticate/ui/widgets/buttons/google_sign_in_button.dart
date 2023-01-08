import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key, required this.signInWithGoogle});

  final Function signInWithGoogle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.onSurface,
          foregroundColor: Theme.of(context).colorScheme.onSecondary,
          minimumSize: const Size(double.infinity, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      onPressed: () {
        signInWithGoogle();
      },
      label: const Text(
        'Sign in with Google.',
        style: TextStyle(fontFamily: 'Montserrat'),
      ),
      icon: Image.asset(
        'assets/icons8-google-48.png',
        scale: 1.5,
      ),
    );
  }
}