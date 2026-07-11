import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.maxLines,
    required this.hintText,
    this.validator,
    required this.title,
    this.icon,
  });
  final TextEditingController controller;
  final int? maxLines;
  final String hintText;
  final Function(String?)? validator;
  final String title;
  final IconButton? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.labelMedium),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: validator != null
              ? (String? value) => validator!(value)
              : null,
          style: Theme.of(context).textTheme.labelMedium,
          decoration: InputDecoration(suffixIcon: icon, hintText: hintText),
        ),
      ],
    );
  }
}
