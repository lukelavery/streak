import 'package:flutter/material.dart';

import '../design/headrer.dart';
import '../design/styled_button.dart';

class PasswordForm extends StatefulWidget {
  const PasswordForm({
    required this.login,
    required this.email,
    required this.cancel,
    super.key,
  });
  final String email;
  final void Function(String email, String password) login;
    final void Function() cancel;
  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_PasswordFormState');
  final _emailController = TextEditingController();
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
        const Header('Sign in'),
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
                            widget.login(
                              _emailController.text,
                              _passwordController.text,
                            );
                          }
                        },
                        child: const Text('SIGN IN'),
                      ),
                      // const SizedBox(width: 30),
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
