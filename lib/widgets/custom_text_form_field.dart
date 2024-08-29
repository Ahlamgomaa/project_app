import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key, required this.hinttext, required this.controller,  this.obscureText=false,required this.validator});
  final String hinttext;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator:validator ,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        filled: true,
        fillColor: Colors.grey[200],
        hintText: hinttext,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}
