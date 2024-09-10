import 'package:flutter/material.dart';

class CustomButtonUpload extends StatelessWidget {
  const CustomButtonUpload({
    super.key,
    required this.text,
    this.onPressed, required this.isSelected,
  });
  final String text;

  final void Function()? onPressed;
 final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 35,
      minWidth: 200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color:isSelected? Colors.blue:Colors.orange,
      textColor: Colors.white,
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
