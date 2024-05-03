import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MyInputField extends StatelessWidget {
  const MyInputField(
      {super.key,
      required this.id,
      required this.label,
      required this.hint,
      required this.isObscure,
      required this.controller});

  final String id;
  final String label;
  final String hint;
  final bool isObscure;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return ShadInputFormField(
      controller: controller,
      id: id,
      label: Text(label),
      placeholder: Text(hint),
      obscureText: isObscure,
      validator: (v) {
        if (v.length < 2) {
          return 'Email must be at least 2 characters.';
        }
        return null;
      },
    );
  }
}
