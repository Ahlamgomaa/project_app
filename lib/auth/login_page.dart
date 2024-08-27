import 'package:flutter/material.dart';
import 'package:project/auth/register_page.dart';

import 'package:project/widgets/custom_button.dart';
import 'package:project/widgets/custom_image.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/custom_text_form_field.dart';
import 'package:project/widgets/custom_textrich.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
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
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'login to continue using the App',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  height: 30,
                ),
                const CustomText(text: 'Email'),
                const SizedBox(
                  height: 5,
                ),
                CustomTextFormField(
                  hinttext: 'Enter your email',
                  controller: email,
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomText(text: 'Password'),
                const SizedBox(
                  height: 5,
                ),
                CustomTextFormField(
                  hinttext: 'Enter your password',
                  controller: password,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  alignment: Alignment.topRight,
                  child: const Text(
                    textAlign: TextAlign.right,
                    'Forget Password?',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            CustomButton(
              text: 'Login    ',
              image: 'images/th (1).jpeg',
              onPressed: () {},
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'OR Login with',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomButton(
              text: 'Login With Google     ',
              image: 'images/google-icon-1.png',
              onPressed: () {},
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextrich(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return const RegisterPage();
                    },
                  ),
                );
              },
              richText: " Don't have an account? ",
              spanText: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}
