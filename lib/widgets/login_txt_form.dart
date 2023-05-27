import 'package:flutter/material.dart';
import '../utils/login_text_styles.dart';

class txt_form_field extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final String hintText;
  final bool obscureTxt;
  const txt_form_field({
    super.key,
    this.validator,
    required this.controller,
    required this.hintText,
    this.obscureTxt = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (validator != null) {
          return validator!(value);
        }
      },
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: login_text_style.login_textform_style,
        border: const OutlineInputBorder(),
      ),
      obscureText: obscureTxt,
    );
  }
}
