import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final String? Function(String?)? validate;
  final String hintText;
  final String labelText;
  final IconData prefixIcon;
  final VoidCallback? onTap;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.type,
    required this.validate,
    required this.hintText,
    required this.labelText,
    required this.prefixIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      keyboardType: type,
      validator: validate,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefix: Icon(
          prefixIcon,
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
