import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/auth/login_page.dart';
import 'package:project/home_page.dart';
import 'package:project/widgets/custom_button.dart';
import 'package:project/widgets/custom_image.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/custom_text_form_field.dart';
import 'package:project/widgets/custom_textrich.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController username = TextEditingController();
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
                  'Register',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Enter your Personal Informatio',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  height: 30,
                ),
                const CustomText(text: 'Username'),
                const SizedBox(
                  height: 5,
                ),
                CustomTextFormField(
                  hinttext: 'Enter your username ',
                  controller: username,
                ),
                const SizedBox(
                  height: 20,
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
                const SizedBox(
                  height: 20,
                ),
                const CustomText(text: 'Confirm Password'),
                const SizedBox(
                  height: 5,
                ),
                CustomTextFormField(
                  hinttext: 'confirm password',
                  controller: password,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: 'Register      ',
                  image: 'images/th (1).jpeg',
                  onPressed: () async {
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      );
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return const HomePage();
                          },
                        ),
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextrich(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const LoginPage();
                        },
                      ),
                    );
                  },
                  richText: ' have an account ?',
                  spanText: 'Login',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
