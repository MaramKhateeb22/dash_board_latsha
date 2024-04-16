import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget(
      {super.key,
      required this.yourController,
      required this.hintText,
      this.onChanged,
      this.obscureText = false,
      this.validator,
      required this.keyboardType,
      this.suffixIcon,
      this.height = 0.3,
      this.maxLines});
  TextEditingController yourController;
  String hintText;
  Function(String)? onChanged;
  Function(String)? validator;
  bool obscureText;
  TextInputType keyboardType;
  Widget? suffixIcon;
  double? height;
  int? maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      style: TextStyle(height: height),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(),
        // hintText: hintText,
        label: Text(hintText),
      ),
      controller: yourController,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'هذا الحقل مطلوب';
        }
        validator;
        return null;
      },
    );
  }
}
