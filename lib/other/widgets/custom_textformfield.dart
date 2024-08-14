import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final bool isShowIcon;
  // final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final VoidCallback showPass; // Changed from CallbackAction to VoidCallback

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    required this.showPass,
    required this.isShowIcon,
    // required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        style: const TextStyle(fontFamily: 'f'),
        // controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelStyle: const TextStyle(fontFamily: 'f'),
          prefixStyle: const TextStyle(fontFamily: 'f'),
          hintText: hintText,
          hintStyle: const TextStyle(fontFamily: 'f'),
          suffixIcon: isShowIcon
              ? GestureDetector(
            onTap: showPass,
            child: Icon(isPassword ? Icons.visibility_off : Icons.visibility),
          )
              : const SizedBox(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.black26,
            ),
          ),
        ),
      ),
    );
  }
}
