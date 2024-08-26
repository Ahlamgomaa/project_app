import 'package:flutter/material.dart';
import 'package:project/widgets/custom_image.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomImage(),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Login',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'login to continue using the App',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Email',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                TextFormField(),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                TextFormField(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
