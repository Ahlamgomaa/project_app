import 'package:flutter/material.dart';

class CustomTextrich extends StatelessWidget {
  const CustomTextrich({super.key, this.onTap, required this.richText, required this.spanText});
  final void Function()? onTap;
  final String richText;
  final String spanText;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: RichText(
          text: TextSpan(
            text: richText,
            style: TextStyle(color: Colors.black),
            children: [
              TextSpan(
                text: spanText,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
