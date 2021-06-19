import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final String hint;
  final bool secure;
  final IconData prefix;
  TextEditingController controller;
  final Function(String) onclick;
  final Function(String) validator;
  final TextInputType type;

  CustomTextField(
      {this.hint,
      this.secure = false,
      this.prefix,
      this.onclick,
      this.validator,
      this.type,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      onSaved: onclick,
      controller: controller,
      validator: validator,
      obscureText: secure,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(
          prefix,
          color: Colors.lightGreen,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white)),
      ),
    );
  }
}
