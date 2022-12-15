import 'package:flutter/material.dart';

import '../design/headrer.dart';
import '../design/styled_button.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    required this.registerAccount,
    required this.cancel,
    required this.email,
    super.key,
  });
  final String email;
  final void Function(String email, String displayName, String password)
      registerAccount;
  final void Function() cancel;
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_RegisterFormState');
  final _emailController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Header('Create account'),
        SizedBox(
          height: 15,
        ),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                ),
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your email address to continue';
                    }
                    return null;
                  },
                ),
              TextFormField(
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                ),
                controller: _displayNameController,
                decoration: const InputDecoration(
                  hintText: 'First & last name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your account name';
                  }
                  return null;
                },
              ),
              TextFormField(
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                ),
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your password';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: widget.cancel,
                      child: const Text('CANCEL'),
                    ),
                    const SizedBox(width: 16),
                    StyledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.registerAccount(
                            _emailController.text,
                            _displayNameController.text,
                            _passwordController.text,
                          );
                        }
                      },
                      child: const Text('SAVE'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
