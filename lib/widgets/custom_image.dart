import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 50),
      child: Center(
        child: CircleAvatar(
          radius: 60,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage('images/Ahlam.jpg'),
          ),
        ),
      ),
    );
  }
}
