import 'package:flutter/material.dart';

import '../design/headrer.dart';
import '../design/styled_button.dart';

class EmailForm extends StatefulWidget {
  const EmailForm({required this.callback, super.key});
  final void Function(String email) callback;
  @override
  State<EmailForm> createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_EmailFormState');
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Header('Enter your email to begin.'),
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
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your email address to continue';
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0),
                    child: StyledButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          widget.callback(_controller.text);
                        }
                      },
                      child: const Text('NEXT'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
