// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController textController;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? isreadOnly;
  final bool? isObscureText;
  final TextInputType? keyboardType;
  final int? maxLength;
  final VoidCallback? onTap;
  final Function? onChanged;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.textController,
    this.prefixIcon,
    this.isreadOnly = false,
    this.suffixIcon,
    this.isObscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.onTap,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      onChanged: (query) {
        if (onChanged != null) {
          onChanged!(query);
        }
      },
      buildCounter: (BuildContext context,
          {int? currentLength, bool? isFocused, int? maxLength}) {
        return null; // This hides the counter
      },
      maxLength: maxLength,
      keyboardType: keyboardType,
      readOnly: isreadOnly!,
      controller: textController,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: labelText,
        suffixIcon: suffixIcon,
      ),
      obscureText: isObscureText!,
      validator: (value) {
        if (value!.isEmpty) {
          return '$labelText is missing!';
        }
        return null;
      },
    );
  }
}
